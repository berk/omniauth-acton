# OmniAuth for Act-On
[![Build Status](https://travis-ci.org/berk/omniauth-acton.png?branch=master)](https://travis-ci.org/berk/omniauth-acton)
[![Coverage Status](https://coveralls.io/repos/berk/omniauth-acton/badge.png?branch=master)](https://coveralls.io/r/berk/omniauth-acton?branch=master)
[![Gem Version](https://badge.fury.io/rb/omniauth-acton.svg)](http://badge.fury.io/rb/omniauth-acton)

Acton OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side. Read the Acton docs for more details: 

https://developers.getbase.com/docs/rest/articles/oauth2/introduction

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-acton'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Acton` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :acton, ENV['ACTON_CLIENT_ID'], ENV['ACTON_SECRET']
end
```

## Configuring

You can configure several options, which you pass in to the `provider` method via a `Hash`:

* `scope`: A space-separated list of scopes you want to request from the user. See the Acton docs for a full list of available permissions.

For example, to request `profile` permission:
 
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :acton, ENV['ACTON_CLIENT_ID'], ENV['ACTON_SECRET'], :scope => 'profile'
end
```

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

```ruby
{"provider"=>"acton",
 "uid"=>33333,
 "info"=>
  {
   "name"=>"Name"},
 "credentials"=>
  {"token"=>
    "dfkjadlfkjasdkjflaskdjfjsldflasjdflkasdjflaskdjf",
   "refresh_token"=>"lkfkjasldjkflaskjdflkasjdlfjkasdljfk",
   "expires_at"=>1489053154,
   "expires"=>true},
 "extra"=>
  {"user"=>
    {
     "id"=>33333,
     "name"=>"name",
     "time_format"=>"12H",
     "timezone"=>"UTC-08:00",
     "created_at"=>"2015-05-12T01:01:15Z",
     "updated_at"=>"2017-03-13T17:31:22Z",
     "currency"=>"USD",
     "phone"=>"+1 111-111-1111"}}}
```

The precise information available may depend on the permissions which you request.
