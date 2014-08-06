require 'rails_helper'

describe WidgetWithOptions do
  subject(:widget) { described_class.new :name => 'widget-name', :code => 1234 }

  describe :to_csv do
    subject { widget.to_csv(options) }

    context 'with style = :full' do
      let(:options) { {:style => :full} }
      it do
        should == <<-CSV.strip_heredoc
          name,code,full
          widget-name,1234,true
        CSV
      end
    end

    context 'with style = :short' do
      let(:options) { {:style => :short} }
      it do
        should == <<-CSV.strip_heredoc
          name,code
          widget-name,1234
        CSV
      end
    end
  end
end