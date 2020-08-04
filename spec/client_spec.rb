# frozen_string_literal: true

RSpec.describe Sourcescrub::Client do
  let(:client) { described_class.new }

  describe 'Companies API' do
    it 'be able to get company data' do
      response = VCR.use_cassette('company_domain_by_ekohe_com') do
        client.company('ekohe.com')
      end

      expect(response.name).to eq('Ekohe, Ltd.')
      expect(response.domain).to eq('ekohe.com')
    end

    it 'raise error when the company not found' do
      expect do
        VCR.use_cassette('company_domain_with_icmoc_com') do
          client.company('icmoc.com')
        end
      end.to raise_error(Sourcescrub::Error, 'Company not found')
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

      expect(company_people.x_ratelimit_limit).to eq('10000')
    end

    it 'be able to get company\'s financials data' do
      company_financials = VCR.use_cassette('company_financials_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'financials' })
      end

      expect(company_financials.total).to eq(0)
      expect(company_financials.type).to eq(Sourcescrub::Models::Financial)
      expect(company_financials.items.size).to eq(0)
    end
  end

  describe 'Sources API' do
    it 'be able to get source data' do
      response = VCR.use_cassette('sources_with_7LNWERLR') do
        client.sources('7LNWERLR')
      end

      expect(response.id).to eq('7LNWERLR')
      expect(response.officialTitle).to eq('Software Magazine 2014 Software 500')
    end

    it 'be able to get source\'s companies' do
      expect do
        VCR.use_cassette('sources_companies_with_7LNWERLR') do
          client.source_companies('7LNWERLR')
        end
      end.to raise_error(Sourcescrub::Error, 'Internal Server Error')
    end

    it 'returns all sources' do
      response = VCR.use_cassette('sources_all_sources') do
        client.all_sources
      end

      expect(response.items.size).to eq(100)
      expect(response.total).to eq(10_000)
      expect(response.items[0].id).to eq('VDM8K99D')
      expect(response.items[0].officialTitle).to eq('Vancouver BC CISO Virtual Town Hall 2020')
    end
  end
end
