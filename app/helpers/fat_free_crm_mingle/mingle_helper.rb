module FatFreeCrmMingle
  module MingleHelper
    def mingle_configured?
      Setting[:mingle] && Setting[:mingle][:url].present?
    end
  end
end
