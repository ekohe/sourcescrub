# frozen_string_literal: true

require 'singleton'

# Root Sourcescrub
module Sourcescrub
  # Account
  class Account
    include Singleton
    attr_accessor :username, :password, :basic, :debug
  end

  def self.account
    yield Account.instance if block_given?

    Account.instance
  end
end
