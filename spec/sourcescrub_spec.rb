# frozen_string_literal: true

RSpec.describe Sourcescrub do
  it 'has a version number' do
    expect(Sourcescrub::VERSION).not_to be nil
  end

  it 'release 0.0.1' do
    expect(Sourcescrub::VERSION).to eq('0.0.1')
  end
end
