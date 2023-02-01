require 'rails_helper'

class Serializable
  include ActiveModel::Serialization
end

class NonSerializable; end

describe Serializable do
  it { should respond_to :as_csv }
end

describe NonSerializable do
  it { should_not respond_to :as_csv }
end
