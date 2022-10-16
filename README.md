[![Coverage Status](https://coveralls.io/repos/jasoncarty/booking_system_ruby/badge.svg?branch=master&service=github)](https://coveralls.io/github/jasoncarty/booking_system_ruby?branch=master)

# Booking system

An application for creating events and inviting guests to these events.

## Development

Ruby Version 3.1.2
Rails Version 7.0.4

```bash
git clone https://github.com/jasoncarty/booking_system_ruby.git
bundle
bundle exec rake db:create db:migrate db:seed
```

To start the app run:

```bash
rails s
```
## Test
```bash
RAILS_ENV=test bundle exec rake db:prepare
bundle exec rspec
```