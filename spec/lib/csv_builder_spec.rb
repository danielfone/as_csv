require 'spec_helper'

describe AsCSV::CSVBuilder do
  subject(:csv_builder) { described_class.new records, options }
  let(:records)  { nil }
  let(:options) { Hash.new }

  EXPOSED_METHODS = [:headers, :rows, :data_rows, :to_csv].freeze

  describe '#rows' do
    subject(:rows) { csv_builder.rows }
    before { csv_builder.stub headers: headers, data_rows: data_rows, "valid?" => true }
    let(:headers)   { %w(h1 h2) }
    let(:data_rows) { [%w(v11 v12), %w(v21 v22)] }

    specify { csv_builder.should be_valid }
    it { should == [headers, *data_rows] }
  end
  
  context 'with single record' do
    let(:records) do
      stub(:foo, as_csv: {
        first:  '1',
        second: '2',
        third:  '3'
      })
    end

    its(:headers)      { should == [:first, :second, :third] }
    its(:data_rows)    { should == [%w(1 2 3)] }
    its(:to_csv) do
      should == <<-CSV
first,second,third
1,2,3
      CSV
    end
  end

  context 'with homogenous records' do
    let(:records) { [record1, record2] }
    2.times do |i|
      let("record#{i+1}") do
        stub(:foo, as_csv: {
          first:  "1#{i}",
          second: "2#{i}",
          third:  "3#{i}"
        })
      end
    end

    its(:headers)   { should == [:first, :second, :third] }
    its(:data_rows) { should == [%w(10 20 30), %w(11 21 31)] }
    its(:to_csv) do
      should == <<-CSV
first,second,third
10,20,30
11,21,31
      CSV
    end
  end

  context 'with hetreogenous records' do
    let(:records) { [record1, record2] }
    2.times do |i|
      let("record#{i+1}") do
        stub(:foo, as_csv: {
          "first#{i}"  => "1#{i}",
          "second#{i}" => "2#{i}",
          "third#{i}"  => "3#{i}"
        })
      end
    end

    its(:headers)      { should == %w(first0 second0 third0 first1 second1 third1) }
    its(:data_rows)    { should == [["10", "20", "30", nil, nil, nil], [nil, nil, nil, "11", "21", "31"]] }
    its(:to_csv) do
      should == <<-CSV
first0,second0,third0,first1,second1,third1
10,20,30,,,
,,,11,21,31
      CSV
    end
  end

  context 'with nil record' do
    let(:records) { nil }

    it { should_not be_valid }
    EXPOSED_METHODS.each do |method|
      its(method) { should == nil }
    end
  end

  context 'with record not respond_to? `as_csv`' do
    let(:records) { stub(:foo) }

    it { should_not be_valid }
    EXPOSED_METHODS.each do |method|
      its(method) { should == nil }
    end
  end

  context 'with record `as_csv` != Hash' do
    let(:records) { stub(:foo, as_csv: 'test') }

    message = "expected as_csv to return Hash"
    ([:valid?] + EXPOSED_METHODS).each do |method|
      specify(%Q{`#{method}` should raise "#{message}"}) do
        expect { csv_builder.send method }.to raise_error TypeError, message
      end
    end
  end

end
