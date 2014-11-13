# skuld

[![Build Status](https://travis-ci.org/dentarg/skuld.svg?branch=master)](https://travis-ci.org/dentarg/skuld)

**skuld** calculates who owes who money.

The app expects a Google Docs spreadsheet with the following content.

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

Share the spreadsheet with **`skuldapp@gmail.com`** (only view access needed) and go to https://skuld.starkast.net/<[spreadsheet key]>.

See [https://skuld.starkast.net/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg][demo] for a demo (and here's a [link to the actual spreadsheet][demosheet]).

[spreadsheet key]: https://productforums.google.com/forum/#!topic/docs/Vx0rggpH9nQ
[demo]: https://skuld.starkast.net/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg
[demosheet]: https://docs.google.com/spreadsheets/d/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg/pubhtml

## Development

### Start

    skuld

### Deploy

    git push heroku

### Environment variables

    GOOGLE_USER
    GOOGLE_PASSWORD

Note: You either need to [allow less secure apps] to access the Google account, or, if you use [2-Step Verification], create an [app password].

[allow less secure apps]: https://support.google.com/accounts/answer/6010255
[2-Step Verification]: https://support.google.com/accounts/answer/180744?hl=en
[app password]: https://support.google.com/accounts/answer/185833?hl=en&topic=2784804&ctx=topic
