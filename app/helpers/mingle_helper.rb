module MingleHelper
  def mingle_configured?
    Setting[:mingle] && Setting[:mingle][:url].present?
  end

  # either returns a list of mingle tickets or string to indicate an error
  def tickets_related_to(related)
    begin
      Mingle.all(:conditions => ["'CRM #{related.class.name}' = #{related.id}"])
    rescue SocketError, ActiveResource::UnauthorizedAccess, URI::BadURIError => e
      Rails.logger.warn("Error in mingle_helper.rb: #{e}")
      Rails.logger.warn(e.backtrace.join("\n"))
      e
    end
  end
  
end
