# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trans_union/version'

Gem::Specification.new do |s|
  s.name        = 'trans_union'
  s.version     = TransUnion::VERSION
  s.date        = '2017-05-01'
  s.summary     = 'Ruby wrapper around the TransUnion TLOxp API'
  s.description = 'Implements the TransUnion TLOxp SOAP API in the friendlier ruby way.'
  s.authors     = ['Bradley Berger']
  s.email       = 'bradley@confidentfs.com'
  s.files       = ['lib/trans_union.rb']
  s.homepage    = 'http://rubygems.org/gems/trans_union'
  s.license     = 'MIT'
end
