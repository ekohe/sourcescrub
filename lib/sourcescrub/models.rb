# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    autoload :Entity,           'sourcescrub/models/concerns/entity'
    autoload :Company,          'sourcescrub/models/company'
    autoload :CompanyItems,     'sourcescrub/models/concerns/company_items'
    autoload :SourceItems,      'sourcescrub/models/concerns/source_items'
    autoload :Source,           'sourcescrub/models/source'
    autoload :Tag,              'sourcescrub/models/tag'
    autoload :Person,           'sourcescrub/models/person'
    autoload :Financial,        'sourcescrub/models/financial'
    autoload :Investment,       'sourcescrub/models/investment'
    autoload :Employee,         'sourcescrub/models/employee'
    autoload :EmployeeRange,    'sourcescrub/models/employee_range'
  end
end
