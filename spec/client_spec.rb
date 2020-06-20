# frozen_string_literal: true

RSpec.describe Sourcescrub::Client do
  let(:client) { described_class.new }

  context 'Companies API' do
    it 'be able to get company data' do
      company = VCR.use_cassette('company_domain_by_ekohe.com') do
        client.companies('ekohe.com')
      end

      expect(company.name).to eq('Ekohe, Ltd.')
      expect(company.domain).to eq('ekohe.com')
    end
  end
end
