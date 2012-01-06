module ::FatFreeCrmMingle
  class Engine < Rails::Engine
    config.to_prepare do
      if (Setting[:mingle].blank? rescue true)
        puts "Please configure your mingle settings"
      else
        require 'fat_free_crm_mingle/mingle_view_hooks'
        FatFreeCRM::Tabs.admin << {
          :text => "Mingle",
          :url => { :controller => "admin/mingle" }
        }
        ActionView::Base.send :include, FatFreeCrmMingle::MingleHelper
      end
    end
  end
end
