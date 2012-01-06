module ::FatFreeCrmMingle
  class Engine < Rails::Engine
    isolate_namespace FatFreeCrmMingle

    config.to_prepare do
      if defined? ApplicationController
        require 'fat_free_crm_mingle/mingle_view_hooks'
        ActionView::Base.send :include, FatFreeCrmMingle::MingleHelper
      end
    end
  end
end
