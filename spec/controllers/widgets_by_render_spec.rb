require 'spec_helper'

describe WidgetsController do
  before do
    Widget.create! [
      { name: "widget-1", description: 'widget-description-1', code: 1001 },
      { name: "widget-2", description: 'widget-description-2', code: 1002 },
      { name: "widget-3", description: 'widget-description-3', code: 1003 },
      { name: "widget-4", description: 'widget-description-4', code: 1004 },
    ]
  end

  context 'GET show/1.csv' do
    before { get :show, id: 1, format: :csv }
    describe 'response' do
      subject { response }
      its(:code) { should == "200" }
      its(:content_type) { should == "text/csv" }
      its(:body) do
        should = <<-CSV.strip_heredoc
          id,name,description,code
          1,widget-1,widget-description-1,1001
        CSV
      end
    end
  end

  context 'GET index.csv' do
    before { get :index, format: :csv }
    describe 'response' do
      subject { response }
      its(:code) { should == "200" }
      its(:content_type) { should == "text/csv" }
      its(:body) do
        should = <<-CSV.strip_heredoc
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
