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

    it 'be able to returns processed currentEmployeeRange data' do
      response = VCR.use_cassette('company_domain_by_thedigitalbox_net') do
        client.company('thedigitalbox.net')
      end

      expect(response.name).to eq('The Digital Box')
      expect(response.domain).to eq('thedigitalbox.net')
      expect(response.currentEmployeeRange).to eq(nil)
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
      people = VCR.use_cassette('company_people_by_ekohe_com') do
        client.company_cards('ekohe.com', { card_id: 'people' })
      end

      expect(people.total).to eq(2)
      expect(people.type).to eq(Sourcescrub::Models::Person)
      expect(people.items.size).to eq(2)
      expect(people.items[0].email).to eq('maxime@ekohe.com')
      expect(people.items[0].firstName).to eq('Maxime')
      expect(people.items[0].title).to eq('CEO')

      expect(people.x_ratelimit_limit).to eq('10000')
    end

    it 'be able to get company\'s financials data' do
      company_financials = VCR.use_cassette('company_financials_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'financials' })
      end

      expect(company_financials.total).to eq(0)
      expect(company_financials.type).to eq(Sourcescrub::Models::Financial)
      expect(company_financials.items.size).to eq(0)
    end

    it 'be able to get company\'s investments data' do
      investments = VCR.use_cassette('company_investments_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'investments' })
      end

      expect(investments.total).to eq(7)
      expect(investments.type).to eq(Sourcescrub::Models::Investment)
      expect(investments.items.size).to eq(7)
      expect(investments.items[0].amount).to eq(50_000_000)
      expect(investments.items[0].dateOfRaise).to eq('2018-07-11')
      expect(investments.items[0].round).to eq('Series C')
      expect(investments.items[0].investors).to eq('3')
      expect(investments.items[0].valuation).to eq(nil)
    end

    it 'be able to get company\'s employees data' do
      employees = VCR.use_cassette('company_employees_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'employees' })
      end

      expect(employees.total).to eq(7)
      expect(employees.type).to eq(Sourcescrub::Models::Employee)
      expect(employees.items.size).to eq(7)
      expect(employees.items[0].count).to eq(337)
      expect(employees.items[0].date).to eq('2019-12-27')
    end

    it 'be able to get company\'s employeerange data' do
      employeeranges = VCR.use_cassette('company_employeerange_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'employeerange' })
      end

      expect(employeeranges.total).to eq(7)
      expect(employeeranges.type).to eq(Sourcescrub::Models::EmployeeRange)
      expect(employeeranges.items.size).to eq(7)
      expect(employeeranges.items[0].employeeRange).to eq('201-500')
      expect(employeeranges.items[0].date).to eq('2019-12-27')
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
    end
  end

  describe 'Companies API' do
    it 'be able to get companies data' do
      response = VCR.use_cassette('companies_top_100') do
        client.companies
      end

      expect(response.items.size).to eq(100)
      expect(response.total).to eq(10_000)
      expect(response.items[0].id).to eq('MNDEJO42')
      expect(response.items[0].name).to eq('AllClear ID, Inc.')
    end
  end
end
