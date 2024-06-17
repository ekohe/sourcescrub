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

      expect(company_sources.identifier).to eq('ekohe.com')
      expect(company_sources.total).to eq(5)
      expect(company_sources.type).to eq(Sourcescrub::Models::Source)
      expect(company_sources.items.size).to eq(5)
      expect(company_sources.items[0].sourceType).to eq('Industry Conference')
    end

    it 'be able to get company\'s people data' do
      people = VCR.use_cassette('company_people_by_ekohe_com') do
        client.company_cards('ekohe.com', { card_id: 'people' })
      end

      expect(people.identifier).to eq('ekohe.com')
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

      expect(company_financials.identifier).to eq('monday.com')
      expect(company_financials.total).to eq(0)
      expect(company_financials.type).to eq(Sourcescrub::Models::Financial)
      expect(company_financials.items.size).to eq(0)
    end

    it 'be able to get company\'s investments data' do
      investments = VCR.use_cassette('company_investments_by_monday_com') do
        client.company_cards('monday.com', { card_id: 'investments' })
      end

      expect(investments.identifier).to eq('monday.com')
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

      expect(employees.identifier).to eq('monday.com')
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

      expect(employeeranges.identifier).to eq('monday.com')
      expect(employeeranges.total).to eq(7)
      expect(employeeranges.type).to eq(Sourcescrub::Models::EmployeeRange)
      expect(employeeranges.items.size).to eq(7)
      expect(employeeranges.items[0].employeeRange).to eq('201-500')
      expect(employeeranges.items[0].date).to eq('2019-12-27')
    end

    it 'able to get 10 new fields data for company' do
      response = VCR.use_cassette('company_by_XWO6N4OP') do
        client.company('XWO6N4OP')
      end

      expect(response.domain).to eq('nnovation.com')
      expect(response.threeMonthsGrowthRate).to eq(nil)
      expect(response.sixMonthsGrowthRate).to eq(nil)
      expect(response.nineMonthsGrowthRate).to eq(nil)
      expect(response.twelveMonthsGrowthRate).to eq(nil)
      expect(response.growthIntent).to eq(nil)
      expect(response.customScore).to eq(nil)
      expect(response.industries).to eq(['Law Practice & Legal Services'])
      expect(response.modifiedDate).to eq('2024-06-08')
      expect(response.endMarkets).to eq(['Business Services', 'Finance', 'Healthcare'])
      expect(response.productsAndServices).to eq(['Legal Services'])
    end

    it 'able to get company\'s employees data by SS ID' do
      employees = VCR.use_cassette('company_employees_by_XWO6N4OP') do
        client.company_cards('XWO6N4OP', { card_id: 'employees' })
      end

      expect(employees.identifier).to eq('XWO6N4OP')
      expect(employees.total).to eq(57)
      expect(employees.type).to eq(Sourcescrub::Models::Employee)
      expect(employees.items.size).to eq(57)
      expect(employees.items[0].count).to eq(5)
      expect(employees.items[0].date).to eq('2016-05-03')
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

    it 'be able to search source data by filters with limit' do
      response = VCR.use_cassette('sources_by_filters_with_limit') do
        client.source_search({ limit: 10, offset: 0 })
      end

      expect(response.total).to eq(10_000)
      expect(response.items.size).to eq(10)
      expect(response.items[0].officialTitle).to eq('Microbiome R&D and Business Collaboration Forum Europe 2019')
    end

    it 'be able to search source data by filters with dates' do
      response = VCR.use_cassette('sources_by_filters_with_dates') do
        client.source_search(
          limit: 10,
          offset: 0,
          start_date: { from: '2021-01-01', to: '2021-01-14' },
          end_date: { from: '2021-01-01', to: '2021-01-14' },
          order_by: 'startDate ASC'
        )
      end

      expect(response.total).to eq(309)
      expect(response.items[0].startDate).to eq('2021-01-01')
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
