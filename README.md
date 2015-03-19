# AsCSV

[![Build Status](https://travis-ci.org/danielfone/as_csv.png)](https://travis-ci.org/danielfone/as_csv)
[![Dependency Status](https://gemnasium.com/danielfone/as_csv.png)](https://gemnasium.com/danielfone/as_csv)
[![Code Climate](https://codeclimate.com/github/danielfone/as_csv.png)](https://codeclimate.com/github/danielfone/as_csv)

This gem allows you to expose CSV in your apps as you'd expose JSON or XML.

Rails is not strictly required, but currently the magic only works with rails 3.x.

Ruby 1.8 will work, but by default the order of the columns will not be guaranteed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'as_csv'
```

## Basic Usage

Simply add `respond_to :csv` in a controller

```ruby
class WidgetsController < ApplicationController
  respond_to :xml, :json, :csv

  def index
    respond_with Widget.all
  end

  def show
    respond_with Widget.find(params[:id])
  end

end
```

Alternatively:

```ruby
class WidgetsController < ApplicationController
  def index
    respond_to do |format|
      format.csv { render csv: Widget.all }
    end
  end

  def show
    respond_to do |format|
      format.csv { render csv: Widget.find(params[:id]) }
    end
  end
end
```

By default, you don't need to change your models at all.

```ruby
class Widget < ActiveRecord::Base
  # attributes :code, :description, :name
end
```
```
> puts Widget.all.to_csv
id,name,description,code
1,widget-1,widget-description-1,1001
2,widget-2,widget-description-2,1002
3,widget-3,widget-description-3,1003
4,widget-4,widget-description-4,1004
 => nil

> puts Widget.where(code: [1001, 1002]).to_csv
id,name,description,code
1,widget-1,widget-description-1,1001
2,widget-2,widget-description-2,1002

> puts Widget.first.to_csv
id,name,description,code
1,widget-1,widget-description-1,1001
 => nil
```

Behind the scenes, any classes that `include ActiveModel::Serialization` will expose their `attributes` with `to_csv`.

## Advanced Usage

### Customizing the CSV

To change what's included in the CSV, define an `as_csv` method. This method must return a Hash.

```ruby
class Widget < ActiveRecord::Base
  # attributes :code, :description, :name

  def as_csv(options={})
    attributes.slice('name', 'code')
  end

end
```
```
> puts Widget.all.to_csv
name,code
widget-1,1001
widget-2,1002
widget-3,1003
widget-4,1004
 => nil
>
```

You can also accept options:

```ruby
class WidgetsController < ApplicationController
  respond_to :csv

  def index
    respond_with Widget.all, style: :short
  end
end
```
```ruby
class Widget < ActiveRecord::Base
  attr_accessible :code, :description, :name

  def as_csv(options={})
    if options[:style] == :short
      attributes.slice('name', 'code')
    else
      attributes
    end
  end

end
```

### Heterogenous Arrays
You can render any Array of objects that respond to `as_csv`.

```ruby
class Foo < ActiveRecord::Base
  # attributes: name, description, code
end
```
```ruby
class Bar < ActiveRecord::Base
  # attributes: name, description, barcode
end
```
```
> puts (Foo.all + Bar.all).to_csv
name,description,code,barcode
foo1,foo1-description,111,
foo2,foo2-description,222,
bar1,bar1-description,,acb12345
bar2,bar2-description,,xyz98765
```

### stdlib CSV options
If you need to pass any options to the underlying CSV library
[docs](http://docs.ruby-lang.org/en/2.0.0/CSV.html#method-c-new):

```
> puts (Foo.all + Bar.all).to_csv csv_options: {col_sep:'|'}
name|description|code|barcode
foo1|foo1-description|111|
foo2|foo2-description|222|
bar1|bar1-description||acb12345
bar2|bar2-description||xyz98765
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure you've got development dependencies: (`bundle`)
4. Ensure existing tests run: (`bundle exec rspec`)
5. Make your changes, including new specs
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request


