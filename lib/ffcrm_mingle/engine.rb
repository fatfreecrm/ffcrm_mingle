module FatFreeCRM
  module Mingle
    class Engine < Rails::Engine

      config.to_prepare do
        require 'ffcrm_mingle/mingle_view_hooks'
        ActionView::Base.send :include, MingleHelper

        tab_urls = FatFreeCRM::Tabs.admin.map{|tab| tab[:url]}.map{|url| url[:controller]}
        unless tab_urls.include? 'admin/mingle'
          FatFreeCRM::Tabs.admin << {:url => { :controller => "admin/mingle" }, :text => "Mingle"}
        end

      end

      # Tell Rails that when generating models, controllers for this engine to use RSpec and FactoryGirl, instead of the default of Test::Unit and fixtures
      config.generators do |g|
        g.test_framework      :rspec,        :fixture => false
        g.fixture_replacement :factory_girl, :dir => 'spec/factories'
        g.assets false
        g.helper false
      end

    end
  end
end
