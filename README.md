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

Use the authentication credentials provided by TransUnion when you sign up for api access:

### TLOxp
```ruby
TransUnion.configure do |config|
  # todo
end

```

## Using TLOxp

TLO is namespaces under the TransUnion Module. Example of how to create a TLO client:
```ruby
client = TransUnion::TLO::Client.new
```

### Simple Person Search

// TODO

### Comprehensive Person Search

// TODO

## Using IDxp

// TODO
