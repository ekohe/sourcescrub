# frozen_string_literal: true

RSpec.describe Sourcescrub do
  it 'has a version number' do
    expect(Sourcescrub::VERSION).not_to be nil
  end

  it 'returns the latest version number' do
    expect(Sourcescrub::VERSION).to eq('0.1.3')
  end
end
