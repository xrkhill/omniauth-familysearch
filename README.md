# Omniauth FamilySearch [![Build Status](https://travis-ci.org/xrkhill/omniauth-familysearch.svg?branch=master)](https://travis-ci.org/xrkhill/omniauth-familysearch)

OmniAuth strategy for FamilySearch OAuth2 API.

There is also a [companion strategy](https://github.com/xrkhill/omniauth-familysearch-identity) for the Identity v2 API (OAuth 1.0a).

Note: FamilySearch [requires](https://familysearch.org/developers/docs/guides/authentication) web apps to use the OAuth 2 API.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-familysearch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-familysearch

## Usage

```ruby
use OmniAuth::Builder do
  provider :familysearch, ENV['FAMILYSEARCH_DEVELOPER_KEY'], ''
end

# To use the sandbox API
use Omniauth::Builder do
  provider :familysearch, ENV['FAMILYSEARCH_DEVELOPER_KEY'], '',
    :client_options => { :site => 'https://sandbox.familysearch.org' }
end
```

## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "familysearch",
  "uid" => "MMMM-QY4Y",
  "info" => {
    "name" => "John Doe",
    "email" => "jdoe@example.com"
  },
  "credentials" => {
    "token" => "56421fc9ac",
    "secret" => "6f532ad1bb"
  },
  "extra" => {
    "access_token" => "56421fc9ac",
    "raw_info" => {
      "users" => [
        {
          "id" => "MMMM-QY4Y",
          "contactName" => "John Doe",
          "email" => "jdoe@example.com",
          "links" => {
            "self" => {
              "href" => "https://sandbox.familysearch.org/platform/users/current?access_token=abc123"
            }
          }
        }
      ]
    }
  }
}
```

## FamilySearch OAuth 2 Docs

https://familysearch.org/developers/docs/guides/authentication

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
