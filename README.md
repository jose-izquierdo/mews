[![Mews CI/CD](https://github.com/jose-izquierdo/mews/actions/workflows/main.yml/badge.svg?branch=master)](https://github.com/jose-izquierdo/mews/actions/workflows/main.yml)

# Mews

## Description

This gem provides an easy-to-use interface for obtaining exchange rates between currencies.
You can integrate it into your application to perform currency conversions effortlessly and efficiently.
Explore the world of international finance with ease!

## Installation

1. Ensure you have Ruby version 3.2.2 installed on your system.

2. Add the gem to your Gemfile:

```ruby
ruby '3.2.2'

source 'https://rubygems.org'

gem 'mews', git: 'https://github.com/jose-izquierdo/mews.git'
```

3. Run `bundle install` to install the gems and its dependencies.

## Design Decisions

### Classes Overview

#### ExchangeRateFetcher
The `ExchangeRateFetcher` class is responsible for fetching exchange rates from an external source. It retrieves the latest rates and is a critical component for keeping the data up-to-date.

#### ExchangeRateProvider
The `ExchangeRateProvider` class manages the logic for providing exchange rates. It utilizes a `Hash` to efficiently store and retrieve rates. Rates are fetched through the `ExchangeRateFetcher`, and the provider maintains a cache to minimize external requests within a 24-hour timeframe.

#### ExchangeRateUpdater
The `ExchangeRateUpdater` class acts as a coordinator, providing access to different `ExchangeRateProvider` instances based on the base currency. It ensures that each base currency has its own provider to manage and update exchange rates.

### Caching Strategy

The decision to incorporate a caching strategy aims to balance the need for real-time data and the desire to reduce external API calls. Exchange rates are stored in a binary search tree for quick retrieval. If the cache is within a 24-hour window, the precalculated rates are used, optimizing performance.

### Manual Execution

To manually run the script (`scripts/main_script.rb`), you can modify the `currencies` array to retrieve exchange rates for specific currencies. Additionally, you can change the `base_currency` to reflect the desired base currency. The `base_currency` should be valid inside the system. 

```console
$ ruby scripts/main_script.rb   
```

## Testing
```console
$ bundle exec rspec
```

## Code Linting
```console
$ bundle exec rubocop
```

## Security Audit
```console
$ bundle exec bundler-audit check
```

## Building the Gem

To build the gem and create a distributable `.gem` file, you can use the `gem build` command. This process compiles your gem and packages it for distribution.

### Prerequisites

Before building the gem, ensure that you have the necessary dependencies installed and your gemspec file (`.gemspec`) correctly configured.

### Build Command

Use the following command in your terminal to initiate the build process:

```console
$ gem build
```

## Contributing
Feel free to contribute to the development of this gem by forking the repository, making your changes, and submitting a pull request.

## License
This gem is open-source and available under the MIT License.
