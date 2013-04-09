class Admin::MingleController < Admin::ApplicationController
  before_filter :require_user
  before_filter "set_current_tab('admin/mingle')", :only => [ :index ]

  # GET /mingle
  #----------------------------------------------------------------------------
  def index
    @mingle = Setting[:mingle] ||= {}

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # PUT /mingle
  #----------------------------------------------------------------------------
  def update
    @mingle = params[:mingle]

    if params[:save]
      Setting[:mingle] = @mingle
      Mingle.reset
      flash[:notice] = 'Mingle settings saved'

    elsif params[:test]
      begin
        cards = Mingle.all(:conditions => ['Owner = CURRENT USER'])
        flash[:notice] = "Successfully connected to Mingle"
      rescue Exception => e
        flash[:error] = "Error connecting to Mingle. Please check your settings."
      end

    end

    respond_to do |format|
      format.js # update.js.rjs
    end
  end
end
