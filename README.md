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
  config.dppa_purpose = 1
  config.glb_purpose = 1
  config.permissible_use_code = 1
  # ... etc
end
```

#### All Available WSDL Operations

[abbreviated_person_search, bankruptcy_records_search, _**basic_person_search**_, business_bankruptcies_search, business_combo_search, 
business_phone_search, business_search, business_judgments_search, business_liens_search, comprehensive_address_search, 
comprehensive_address_search_v2, comprehensive_business_search, comprehensive_person_search, comprehensive_phone_search, 
corporate_filing_search, criminal_search, death_master_search, drivers_license_search, echo_test, email_search, eviction_search, 
foreclosure_search, locate_report, personal_judgment_search, personal_lien_search, _**person_search**_, phone_search, phone_search_plus, 
professional_license_search, property_deed_search, property_search, property_tax_search, relationship_graph, screening_search, 
social_networks_search, super_phone_report, super_reverse_phone_search, ucc_search, utility_connection_search, _**vehicle_search**_, 
vehicle_tag_sightings_report, vehicle_wildcard_search, id_verification, verify_plus, voter_registration_search, watch_list_search]
 
__bold__ = currently implemented

*Many of these wsdl endpoints share same or similar input formats and this gem could easily be entended to include more
operations.  See TLOxp documentation for more information.



## Using TLOxp

TLO is namespaced under the TransUnion Module. 
Example of how to make a BasicPersonSearch call:
```ruby
options = {
  name: { first_name: 'Gnarles', last_name: 'Barkley' },
  phone: '9705554688'
}

response = TransUnion::TLO.basic_person_search(options)
```



## Using IDxp

// TODO
