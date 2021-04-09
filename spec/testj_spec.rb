require 'spec_helper'

RSpec.describe Testj do
  it 'has a version' do
    expect(Testj::VERSION).not_to be nil
  end

  it 'has hello' do
    t = Testj
    expect(t.hello).to be nil
  end
end
