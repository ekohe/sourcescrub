# Change Log

## [0.1.3] - 2024-06-17

- Get company data by SS ID - `client.company('XWO6N4OP')`
- Pull new fields of company
    - threeMonthsGrowthRate
    - sixMonthsGrowthRate
    - nineMonthsGrowthRate
    - twelveMonthsGrowthRate
    - growthIntent
    - customScore
    - industries
    - modifiedDate
    - endMarkets
    - productsAndServices

## [0.1.2] - 2021-01-14

- Implement search source endpoint to allow use filters to get matched sources - `client.source_search({limit: 10, offset: 0})`

## [0.1.1] - 2020-11-03

- Fixing wrong data issue of `currentEmployeeRange` in Company

## [0.0.8] - 2020-08-13

- Implement API to request all compnies - `client.companies`

## [0.0.7] - 2020-08-04

- Get source data and source compaines - `client.source_companies(source_id)`
- Get company's employeerange data by domain -  `client.company_cards('monday.com', { card_id: 'employeerange' })`
- Get company's employees data by domain -  `client.company_cards('monday.com', { card_id: 'employees' })`

## [0.0.3] - 2020-06-20

- Implement API to request token by user certificate
- Get company data by domain - `client.company('ekohe.com')`
- Get company's relationship data by domain -  `client.company('ekohe.com', {card_id: 'people'})`
- Retrieve request limit data from header

```
    #   .date
    #   .content_type
    #   .server
    #   .content_length
    #   .request_context
    #   .strict_transport_security
    #   .x_ratelimit_limit
    #   .x_ratelimit_remaining
    #   .x_ratelimit_reset
```
