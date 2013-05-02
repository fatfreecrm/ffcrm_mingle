# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ffcrm_mingle/version'

Gem::Specification.new do |s|
  s.name = 'ffcrm_mingle'
  s.authors = ['Ben Tillman', 'Joshua Kunzmann', 'Stephen Kenworthy']
  s.summary = 'Fat Free CRM - Mingle integration'
  s.description = 'This Fat Free CRM plugin provides create and view functionality for Mingle tickets inside the CRM.'
  s.files = `git ls-files`.split("\n")
  s.version = FatFreeCRM::Mingle::VERSION

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'pg'
  s.add_dependency 'fat_free_crm'
  s.add_dependency 'mingle4r'
end
