# README
This Ruby-based application implements a simple checkout system for a supermarket with flexible pricing rules. The system supports dynamic offers, such as Buy-One-Get-One-Free and bulk discounts, which are configured via a JSON file. It provides functionality to scan products, calculate the total price, and test the pricing logic using RSpec.

Features

• Dynamic Offers: Pricing rules configured through a JSON file for flexibility.

• Scalable Architecture: Clean separation of concerns with Checkout and PriceCalculator classes.

• Offer Types Supported:

• Buy-One-Get-One-Free (BOGO)

• Bulk discounts

• Volume discounts with percentage off

• RSpec Tests: Comprehensive tests for both public and private methods.


* Ruby version
  Ruby 2.7+

* System dependencies
  Bundler for managing dependencies

* Configuration

* How to run the test suite
  bundle exec rspec

* Setup

1. Clone the repository:
  git clone https://github.com/shivic7/cart_checkout.git
  cd cart_checkout

2. Install dependencies:
  bundle install

3. Run the tests:
  bundle exec rspec

4. Run the application(Run main.rb and output the total price for scanned products.):
  ruby main.rb
