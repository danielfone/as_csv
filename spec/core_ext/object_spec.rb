require 'as_csv'

describe Object do
  it { should respond_to(:to_csv) }
  specify do
    AsCSV::CSVBuilder.any_instance.should_receive(:to_csv).and_call_original
    subject.to_csv
  end
end
