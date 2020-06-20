# frozen_string_literal: true

module Sourcescrub
  # Models
  module Models
    autoload :Entity,   'sourcescrub/models/concerns/entity'
    autoload :Company,  'sourcescrub/models/company'
    autoload :Source,   'sourcescrub/models/source'
    autoload :Tag,      'sourcescrub/models/tag'
  end
end
