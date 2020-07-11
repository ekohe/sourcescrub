# Sourcescrub

Sourcescrub is a ruby wrapper based on Source Scrub API, Here is API documentation: https://api.sourcescrub.com/index.html.

However, we need to request an access account from Sourcescrub.

[![Gem Version](https://badge.fury.io/rb/sourcescrub.svg)](https://badge.fury.io/rb/sourcescrub)
[![Build Status](https://travis-ci.org/ekohe/sourcescrub.svg?branch=master)](https://travis-ci.org/ekohe/sourcescrub)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sourcescrub'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sourcescrub

## Getting Started

#### Configure your certificate for API

```ruby
require 'sourcescrub'

account = YAML.load(File.read('sourcescrub.yml'))
Sourcescrub.account do |config|
  config.username = account['username']
  config.password = account['password']
  config.basic    = account['basic']
  config.debug    = false # Default is false, If you want to know the request information, can set the debug = true
end
```

## Usage

#### Class: `Client` for API

```
pry(main)> client = Sourcescrub::Client.new
```

#### Request your token

```
pry(main)> client.headers
=> {"Authorization"=>"Bearer eyJhbGciOiJSUzI1NiIsImtpZCI........"}
```

#### API request for endpoint we completed

- [Companies](https://github.com/ekohe/sourcescrub#companies)
- [Searches](https://github.com/ekohe/sourcescrub#searches)

```ruby
<!-- Company -->
response = client.company('ekohe.com')

<!-- Get the JSON response of Company -->

response.as_json
```

### Companies

####  Get the company data

```ruby
pry(main)> response = client.company('ekohe.com')
=> #<Sourcescrub::Models::Company:0x00007f9e915161c0
 @city="Xinzhuang",
 @companyType="Private",
 @country="China",
 @crunchbase=nil,
 @currentEmployeeCount=41,
 @currentEmployeeRange="11-50",
 @currentJobOpenings=0,
 @description=
  "Ekohe, Ltd. is a cutting-edge web and mobile design and development agency. It specialize in digital strategy, innovative technology and user-centered design experiences from conceptualization to market launch.",
 @domain="ekohe.com",
 @facebook=nil,
=> #<Sourcescrub::Models::Company:0x00007f9e915161c0
 @city="Xinzhuang",
 @companyType="Private",
 @country="China",
 @crunchbase=nil,
 @currentEmployeeCount=41,
 @currentEmployeeRange="11-50",
 @currentJobOpenings=0,
 @description=
  "Ekohe, Ltd. is a cutting-edge web and mobile design and development agency. It specialize in digital strategy, innovative technology and user-centered design experiences from conceptualization to market la
unch.",
 @domain="ekohe.com",
 @facebook=nil,
 @firmTags=[],
 @foundingYear=2007,
 @id="LZ281NVD",
 @informalName="Ekohe",
 @investors="",
 @linkedIn="https://www.linkedin.com/company/ekohe",
 @location="Xinzhuang, Shanghai Shi, China",
 @name="Ekohe, Ltd.",
 @parentCompanyDomain=nil,
 @personalTags=[],
 @phoneNumber="",
 @postalCode=nil,
 @specialties=
  ["IT & Startup Consulting",
   "Ruby on Rails leaders",
   "Intelligent Web & Mobile Development",
   "Usable Web & Mobile design",
   "UX or UI Design",
   "Artificial Intelligence",
   "Machine Learning",
   "Data Sourcing",
   "FinTech Tools"],
 @state="Shanghai Shi",
 @totalAmountInvested=0,
 @twitter=nil,
 @website="https://ekohe.com">
pry(main)> response.name
=> "Ekohe, Ltd."
pry(main)> response.domain
=> "ekohe.com"
pry(main)> response.as_json
=> {:id=>"LZ281NVD",
 :companyType=>"Private",
 :name=>"Ekohe, Ltd.",
 :informalName=>"Ekohe",
 :website=>"https://ekohe.com",
 :domain=>"ekohe.com",
 :description=>
  "Ekohe, Ltd. is a cutting-edge web and mobile design and development agency. It specialize in digital strategy, innovative technology and user-centered design experiences from conceptualization to market launch.",
 :foundingYear=>2007,
 :location=>"Xinzhuang, Shanghai Shi, China",
 :city=>"Xinzhuang",
 :state=>"Shanghai Shi",
 :postalCode=>nil,
 :country=>"China",
 :parentCompanyDomain=>nil,
 :phoneNumber=>"",
 :specialties=>
  ["IT & Startup Consulting",
   "Ruby on Rails leaders",
   "Intelligent Web & Mobile Development",
   "Usable Web & Mobile design",
   "UX or UI Design",
   "Artificial Intelligence",
   "Machine Learning",
   "Data Sourcing",
   "FinTech Tools"],
 :facebook=>nil,
 :twitter=>nil,
 :crunchbase=>nil,
 :linkedIn=>"https://www.linkedin.com/company/ekohe",
 :totalAmountInvested=>0,
 :currentEmployeeCount=>41,
 :currentEmployeeRange=>"11-50",
 :currentJobOpenings=>0,
 :investors=>"",
 :personalTags=>[],
 :firmTags=>[]}
```

### Searches

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/sourcescrub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ekohe/sourcescrub/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sourcescrub project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/sourcescrub/blob/master/CODE_OF_CONDUCT.md).
