require 'spec_helper'
require 'as_csv/csv_builder'

describe AsCSV::CSVBuilder do
  subject(:builder) { described_class.new records, options }
  let(:records)  { nil }
  let(:options) { Hash.new }

  describe '#to_csv' do
    subject { builder.to_csv }

    context 'with single record' do
      let(:records) do
        double(:foo, :as_csv => {
          :first  => '1',
          :second => '2',
          :third  => '3'
        })
      end

      it 'should render correctly' do
        should eq "first,second,third\n1,2,3\n"
      end
    end

    context 'with homogenous records' do
      let(:records) do
        2.times.map do |i|
          double(:foo, :as_csv => {
            :first  => "1#{i}",
            :second => "2#{i}",
            :third  => "3#{i}"
          })
        end
      end

      it 'should render correctly' do
        should == "first,second,third\n10,20,30\n11,21,31\n"
      end
    end

    context 'with hetreogenous records' do
      let(:records) do
        2.times.map do |i|
          double(:foo, :as_csv => {
            "first#{i}"  => "1#{i}",
            "second#{i}" => "2#{i}",
            "third#{i}"  => "3#{i}"
          })
        end
      end

      it 'should merge headers' do
        should == "first0,second0,third0,first1,second1,third1
10,20,30,,,
,,,11,21,31
"
      end
    end

    context 'with record not respond_to? `as_csv`' do
      let(:records) { double(:foo) }

      it 'should raise an error' do
        expect { builder.to_csv }.to raise_error TypeError
      end
    end

    context 'with record `as_csv` != Hash' do
      let(:records) { double(:foo, :as_csv => 'test') }

      it 'should raise an error' do
        expect { builder.to_csv }.to raise_error TypeError
      end
    end
  end

end
