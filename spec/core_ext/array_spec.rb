require 'spec_helper'
require 'as_csv/core_ext/array'

describe Array do
  subject(:array) do
    [
      stub(:foo, :as_csv => {:header => '1'}),
      stub(:foo, :as_csv => {:header => '2'}),
      stub(:foo, :as_csv => {:header1 => '3'}),
    ]
  end

  describe '#to_csv' do
    subject { array.to_csv }

    it 'should use :as_csv on its elements if present' do
      should eq "header,header1\n1,\n2,\n,3\n"
    end

    context 'with mixed elements' do
      before { array << 1 }
      it 'should raise a TypeError' do
        expect { subject }.to raise_error TypeError
      end
    end

    context 'with literals' do
      before { array.clear; array << 1 }
      it 'should not use :as_csv' do
        should eq "1\n"
      end
    end
  end

end
