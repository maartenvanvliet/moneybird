# Moneybird [![Build Status](https://github.com/maartenvanvliet/moneybird/workflows/Ruby/badge.svg?branch=master)](https://github.com/maartenvanvliet/moneybird/actions?query=workflow%3ARuby)

Gem to talk to the Moneybird REST API. Right now you'll need to get a 'bearer' token for the client to work, oauth2 support may added later. This gem is still under construction and any methods may still change signature without notice until 1.0 is released.

The library is modelled after http://developer.moneybird.com/ Any inconsistencies or errors in the documentation may also be present in the library.

Feel free to file Pull Requests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moneybird'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moneybird

## Usage

```ruby
# Client uses bearer token (see: http://developer.moneybird.com/authentication/)
Moneybird::Client.new('fe3f7f9e239e7d925f9caf695028e60fd3e5c2085f7aebb983cea731dea6b44f')

# List administrations
administrations = client.administrations

administration = administrations.first

# List invoices
administration.sales_invoices.all

# List invoices with a specific state
administration.sales_invoices.all(filter: 'state:uncollectible')

# List contacts
administration.contacts.all

# Find contact
administration.contacts.find(moneybird_id)

# Find contact by customer id
administration.contacts.find_by_customer_id(customer_id)

# Create contact
administration.contacts.create(company_name: 'ACME', firstname: 'Foo', lastname: 'Bar')

# Update contact
contact = administration.contacts.all.first
contact.company_name = 'Something new'
administrations.contacts.save(contact)

# Delete contact
administrations.contacts.delete(contact)

# Works similarly with other resources

```
### Webhooks

Moneybird, if so configured, sends webhooks to specified endpoints. This gem can deal with these requests.
```ruby
webhook = Moneybird::Webhook.from_json(request.body)
sales_invoice = webhook.build_entity
sales_invoice.state 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maartenvanvliet/moneybird. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
