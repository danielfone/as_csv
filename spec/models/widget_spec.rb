require 'rails_helper'

describe Widget do
  it { should respond_to :to_csv }
  it { should respond_to :as_csv }

  describe 'dummy' do
    subject(:dummy_widget) { Widget.new :name => "widget-name", :description => 'widget-description', :code => 1234 }

    describe :to_csv do
      subject { dummy_widget.to_csv }
      it do
        should == <<-CSV.strip_heredoc
          id,name,description,code
          ,widget-name,widget-description,1234
        CSV
      end
    end
  end

  describe 'collection' do
    before do
      Widget.create! [
        { :name => "widget-1", :description => 'widget-description-1', :code => 1001 },
        { :name => "widget-2", :description => 'widget-description-2', :code => 1002 },
        { :name => "widget-3", :description => 'widget-description-3', :code => 1003 },
        { :name => "widget-4", :description => 'widget-description-4', :code => 1004 },
      ]
    end

    subject(:widgets) { Widget.order(:id) }

    describe :to_csv do
      subject { widgets.to_csv }
      it do
        should == <<-CSV.strip_heredoc
          id,name,description,code
          1,widget-1,widget-description-1,1001
          2,widget-2,widget-description-2,1002
          3,widget-3,widget-description-3,1003
          4,widget-4,widget-description-4,1004
        CSV
      end
    end
  end

end