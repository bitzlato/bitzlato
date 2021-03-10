# Bitzlato

Ruby HTTP API client library and cli to bitzlato.bz for wallets, trades and money.

## Before usage

1. Sign up to bitzlato.bz
2. Create API key
3. Contact support team to create merchant account

## Command Line Interface (CLI) utility

### Installation

    $ gem install bitzlato


### Setup

Setup credentials and API url:

    $ export BITZLATO_API_KEY='{"kty":"EC","alg":"ES256","crv":"P-256","x":"SECRET","y":"SECRET","d":"SECRET"}'
    $ export BITZLATO_API_URL=https://demo.bitzlato.bz
    $ export BITZLATO_API_CLIENT_UID=YOUR_USER_ID

### Usage

Make requests to bitzlato API:

    $ bitzlato-cli get /api/auth/whoami
    $ bitzlato-cli post /api/gate/v1/invoices/ '{"cryptocurrency":"BTC", "amount":"0.002","comment":"test invoice 2"}'

## Ruby library (usage from code)

### Installation

Add this line to your application's Gemfile:

    $ bundle add bitzlato

And then execute:

    $ bundle install

### Usage


```ruby
client = Bitzlato::Client
  .new(home_url: 'https://demo.bitzlato.bz',
       key: { kty: "EC", alg: "ES256", crv: "P-256", x: "SECRET", y: "SECRET", d: "SECRET"}, # Keys must be symbolized
       uid: 'YOUR USER_ID ', # You must choice uid or email
       email: 'YOU EMAIL',   # You must choice uid or email
       logger: true # Log output to console. Default is false


client.get '/api/auth/whoami'
# {"userId"=>12, "name"=>"dapidapi"}

client.post '/api/gate/v1/invoices/',  cryptocurrency:"BTC", amount: "0.002", comment: "test"
# {"id"=>14, "cryptocurrency"=>"BTC", "amount"=>"0.002", "comment"=>"test invoice 2", 
#  "link"=>{"telegram"=>"https://t.me/null?start=adasda", 
#  "web"=>"https://s-www.lgk.one/p2p/?start=adasdaa"}, 
#  "createdAt"=>1615360123578, "expiryAt"=>1615446523578, "completedAt"=>nil, "status"=>"active"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/finfex/bitzlato. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/finfex/bitzlato/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bitzlato project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/finfex/bitzlato/blob/master/CODE_OF_CONDUCT.md).
