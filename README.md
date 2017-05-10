# TransUnion Ruby Gem

Ruby wrapper for the TransUnion API. Primarily the TLO products, with plans to implement wrapper around
the IDxp product.

## Installation

Add this line to your application's Gemfile:
   
    gem 'trans_union'
    
And then execute:

    $ bundle
    
Or install it without bundler as:

    $ gem install trans_union
    
## Usage

### Configuration

Use the authentication credentials provided by TransUnion for api access:

*note: TransUnion must also whitelist the IP addresses from which you'll be making TLO requests*

### TLOxp
```ruby
TransUnion.configure do |config|
  config.username = 'carl'
  config.password = 'password'
  # ... etc
end

```

## Using TLOxp

TLO is namespaced under the TransUnion Module. Example of how to make a BasicPersonSearch call:
```ruby
options = {
  name: { first_name: 'Gnarles', last_name: 'Barkley' },
  phone: '9705554688'
}

response = TransUnion::TLO.basic_person_search(options)
```

### BasicPersonSearch 

// TODO

### VehicleSearch

// TODO

## Using IDxp

// TODO
