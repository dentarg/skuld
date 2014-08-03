# skuld

### Start

    foreman run bundle exec rackup -p 7979 -E development

### Deploy

    git push heroku

### Environment variables

    GOOGLE_USER
    GOOGLE_PASSWORD

Note: You either need to [allow less secure apps] to access the Google account, or, if you use [2-Step Verification], create an [app password].

[allow less secure apps]: https://support.google.com/accounts/answer/6010255
[2-Step Verification]: https://support.google.com/accounts/answer/180744?hl=en
[app password]: https://support.google.com/accounts/answer/185833?hl=en&topic=2784804&ctx=topic
