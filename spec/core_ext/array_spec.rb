require 'spec_helper'

describe Array do
  it { should respond_to(:to_csv) }
  it { should respond_to(:to_csv_with_builder) }
  it { should respond_to(:to_csv_without_builder) }

  context 'with objects responding to `as_csv`' do
    before { subject << stub(:foo, as_csv: {header: 'value'})}

    specify do
      AsCSV::CSVBuilder.any_instance.should_receive(:to_csv).and_call_original
      subject.should_not_receive(:to_csv_without_builder)
      subject.to_csv
    end
  end

  context 'without objects responding to `as_csv`' do
    before { subject << 1 }

    specify do
      AsCSV::CSVBuilder.any_instance.should_receive(:to_csv).and_call_original
      subject.should_receive(:to_csv_without_builder)
      subject.to_csv
    end
  end

end
