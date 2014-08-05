require 'spec_helper'

describe Array do
  # In place while we undo the monkey-patching shame
  it { should_not respond_to(:to_csv) }
end
