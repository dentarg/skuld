# skuld

[![Build Status](https://travis-ci.org/dentarg/skuld.svg?branch=master)](https://travis-ci.org/dentarg/skuld)

**skuld** calculates who owes who money.

The app expects a [Google Sheets](http://www.google.com/sheets/about/) spreadsheet with the following content.

First worksheet:

| Expense | Cost | Payed by | Shared by              |
|---------|------|----------|------------------------|
| Pizza   | 500  | Ross     | Ross, Monica, Chandler |
| Coke    | 100  | Phoebe   | Rachel, Phoebe         |
| Cake    | 1000 | Monica   | Alla                   |
| Rent    | 5000 | Monica   | Rachel                 |
| Rent    | 3000 | Joey     | Chandler, Ross         |

Second worksheet:

| People   |
|----------|
| Rachel   |
| Monica   |
| Phoebe   |
| Joey     |
| Chandler |
| Ross     |

Share the spreadsheet with **`492957944163-ukbkb7l0su4d7u5pr7sgb8n5psijncm8@developer.gserviceaccount.com`** (only view access needed) and go to https://skuld.starkast.net/<[spreadsheet key]>.

See [https://skuld.starkast.net/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg][demo] for a demo (and here's a [link to the actual spreadsheet][demosheet]).

[spreadsheet key]: https://productforums.google.com/forum/#!topic/docs/Vx0rggpH9nQ
[demo]: https://skuld.starkast.net/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg
[demosheet]: https://docs.google.com/spreadsheets/d/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg/pubhtml

## Development

### Start

    skuld

### Debug

```ruby
require "pry-byebug"
binding.pry # Execution will stop here
```

### Deploy

Deployment is automated by the [Heroku GitHub Deploys](https://devcenter.heroku.com/articles/github-integration#automatic-deploys). Every push to the `master` branch will trigger deployment, if CI passes.

### Environment variables

    GOOGLE_SERVICE_ACCOUNT_ID
    GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY

See [Implementing Server-Side Authorization](https://developers.google.com/drive/web/auth/web-server). Also useful, [How To Store Private Key Files In Heroku](http://ar.zu.my/how-to-store-private-key-files-in-heroku/).

Command to extract the private key from the `.p12` file:

    openssl pkcs12 -in skuld-456631a502d6.p12 -nocerts -passin pass:notasecret -nodes

How to set `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY` with `heroku config` and avoid [OpenSSL::PKey::RSAError - Neither PUB key nor PRIV key: nested asn1 error](https://github.com/opscode-cookbooks/jenkins/issues/148#issuecomment-72346950):

    $ heroku config:set GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> ...
    dquote> -----END RSA PRIVATE KEY-----"
