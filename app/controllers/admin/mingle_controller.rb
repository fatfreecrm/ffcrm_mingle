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
      FatFreeCrmMingle::Mingle.reset
      flash[:notice] = 'Mingle settings saved'

    elsif params[:test]
      flash[:notice] = FatFreeCrmMingle::Mingle.all(:conditions => ['Owner = CURRENT USER'])
    end

    respond_to do |format|
      format.js # update.js.rjs
    end
  end
end
