class Mingle < ActiveResource::Base
  self.site = Setting[:mingle][:url]
  self.user = Setting[:mingle][:username]
  self.password = Setting[:mingle][:password]
  self.element_name = :card

  def self.all(options = {})
    fields = options[:fields] || Setting[:mingle][:fields]
    conditions = ["type = #{Setting[:mingle][:card_type]}"] + (options[:conditions] || [])

    mql = "SELECT #{fields} WHERE #{conditions.join(' AND ')}"
    instantiate_collection get(:execute_mql, :mql => mql)
  end
end
