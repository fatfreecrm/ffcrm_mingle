class Admin::MingleController < Admin::ApplicationController
  before_filter :require_user
  before_filter "set_current_tab('admin/mingle')", :only => [ :index ]

  # GET /mingle
  # GET /mingle.xml                                             AJAX and HTML
  #----------------------------------------------------------------------------
  def index
    respond_to do |format|
      format.html # index.html.haml
      format.js   # index.js.rjs
      format.xml  { render :xml => @super_tags }
    end
  end
end
