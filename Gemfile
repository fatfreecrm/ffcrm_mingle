source 'https://rubygems.org'

require File.expand_path('../lib/bundler/gem_development', __FILE__)
Bundler.development_gems = ['fat_free_crm', /^ffcrm_/]

gemspec

gem 'fat_free_crm', :git => 'git://github.com/fatfreecrm/fat_free_crm.git'

gem 'debugger', :platform => :mri_19 unless ENV["CI"]
