require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_mingle, self) do
           name "Fat Free CRM - Mingle integration"
         author "Ben Tillman"
        version "1.0"
    description "Mingle integration"
   dependencies :haml
            tab :admin, :text => "Mingle", :url => { :controller => "admin/mingle" }
end

if Setting[:mingle].blank?
  puts "Please configure your mingle settings"
else
  require "crm_mingle"
end

