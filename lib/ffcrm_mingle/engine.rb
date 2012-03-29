module FatFreeCRM
  module Mingle
    class Engine < Rails::Engine
      config.to_prepare do
        if (Setting[:mingle].blank? rescue true)
          puts "Please configure your mingle settings"
        else
          require 'ffcrm_mingle/mingle_view_hooks'
          ActionView::Base.send :include, MingleHelper
        end

        begin
          FatFreeCRM::Tabs.admin << {
            :text => "Mingle",
            :url => { :controller => "admin/mingle" }
          }
        rescue TypeError
          puts "You must migrate your settings table."
        end
      end
    end
  end
end
