# Change Log

## [0.0.3] - 2020-06-20

- Implement API to request token by user certificate
- Get company data by domain - `client.company(ekohe.com)`
- Get company's relationship data by domain -  `client.company(ekohe.com, {card_id: 'people'})`
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
