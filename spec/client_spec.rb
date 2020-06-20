# frozen_string_literal: true

RSpec.describe Sourcescrub::Client do
  let(:client) { described_class.new }

  context 'Companies API' do
    let!(:headers) do
      VCR.use_cassette('client_headers') do
        client.headers
      end
    end

    it 'be able to get company data' do
      response = VCR.use_cassette('company_domain_by_ekohe_com') do
        client.company('ekohe.com')
      end

      expect(response.name).to eq('Ekohe, Ltd.')
      expect(response.domain).to eq('ekohe.com')
    end

    it 'be able to get company\'s sources data' do
      company_sources = VCR.use_cassette('company_sources_by_ekohe_com') do
        client.company_cards('ekohe.com', { card_id: 'sources' })
      end

      expect(company_sources.total).to eq(5)
      expect(company_sources.type).to eq(Sourcescrub::Models::Source)
      expect(company_sources.items.size).to eq(5)
      expect(company_sources.items[0].sourceType).to eq('Industry Conference')
    end

    it 'be able to get company\'s people data' do
      company_people = VCR.use_cassette('company_people_by_ekohe_com') do
        client.company_cards('ekohe.com', { card_id: 'people' })
      end

      expect(company_people.total).to eq(2)
      expect(company_people.type).to eq(Sourcescrub::Models::Person)
      expect(company_people.items.size).to eq(2)
      expect(company_people.items[0].email).to eq('maxime@ekohe.com')
      expect(company_people.items[0].firstName).to eq('Maxime')
      expect(company_people.items[0].title).to eq('CEO')

      expect(company_people.x_ratelimit_reset).to eq('900355.5522634999')
      expect(company_people.x_ratelimit_limit).to eq('200')
      expect(company_people.x_ratelimit_remaining).to eq('79')
    end
  end
end
