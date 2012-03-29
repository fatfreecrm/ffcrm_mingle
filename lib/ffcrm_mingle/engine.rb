module FatFreeCRM
  module Mingle
    class Engine < Rails::Engine
      config.to_prepare do
        require 'ffcrm_mingle/mingle_view_hooks'
        ActionView::Base.send :include, MingleHelper

        begin
          FatFreeCRM::Tabs.admin << {
            :text => "Mingle",
            :url => { :controller => "admin/mingle" }
          }
        rescue TypeError
          puts "You must migrate your settings table."
        end

        if Setting[:mingle].blank?
          puts "Please configure your mingle settings"
        end
      end
    end
  end
end
