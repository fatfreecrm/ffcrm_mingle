require 'rubygems'
require 'bundler'

Bundler.require :default, :development

require 'capybara/rspec'

Combustion.initialize!

require 'rspec/rails'
require 'capybara/rails'
require 'vcr'

require 'rspec/autorun'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.mock_with :rspec

  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true

  config.extend VCR::RSpec::Macros
end

@@mingle_settings = {
  :url => 'http://www.example.com/mingle',
  :username => 'joebloggs',
  :password => 'mingletastic',
  :projects => 'project1, project2, project3',
  :card_type => 'Story',
  :fields => 'number, name, status, owner',
}
Setting[:mingle] = @@mingle_settings
