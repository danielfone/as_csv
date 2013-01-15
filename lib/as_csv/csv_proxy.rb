if RUBY_VERSION >= '1.9'
  require 'csv'
  AsCSV::CSVProxy = CSV
else
  begin
    gem 'fastercsv'
    require 'fastercsv'

    AsCSV::CSVProxy = FasterCSV
  rescue LoadError => e
    raise "Error : FasterCSV not installed, please `gem install fastercsv` for faster processing on Ruby 1.8"
  end
end
