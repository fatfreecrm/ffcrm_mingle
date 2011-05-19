require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_mingle, self) do
           name "Fat Free CRM - Mingle integration"
         author "Ben Tillman"
        version "1.0"
    description "Mingle integration"
   dependencies :haml
            tab :admin, :text => "Mingle", :url => { :controller => "admin/mingle" }
end

require "crm_mingle"
