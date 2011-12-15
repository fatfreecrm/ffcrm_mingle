ApplicationHelper.class_eval do
  def mingle_configured?
    Setting[:mingle] && Setting[:mingle][:url].present?
  end
end
