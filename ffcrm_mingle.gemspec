# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ffcrm_mingle/version'

Gem::Specification.new do |s|
  s.name = 'ffcrm_mingle'
  s.authors = ['Ben Tillman', 'Joshua Kunzmann', 'Stephen Kenworthy']
  s.summary = 'Fat Free CRM - Mingle integration'
  s.description = 'Fat Free CRM - Mingle integration'
  s.files = `git ls-files`.split("\n")
  s.version = FatFreeCRM::Mingle::VERSION

  s.add_development_dependency 'rspec-rails', '~> 2.6'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'combustion'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'pg'
  s.add_dependency 'fat_free_crm'
  s.add_dependency 'mingle4r'
end
