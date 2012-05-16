class MingleController < ApplicationController
  before_filter :require_user
  around_filter :handle_active_resource_errors

  # GET /mingle/new
  #----------------------------------------------------------------------------
  def new
    @mingle = Mingle.new(params[:mingle])
  end

  # POST /mingle
  #----------------------------------------------------------------------------
  def create
    @mingle = Mingle.new(params[:mingle])
    @mingle.properties << {'name' => 'owner', 'value' => @current_user.username}
    if @mingle.save
      @mingle = Mingle.all(:conditions => ["number = #{@mingle.number}"]).first
    end
  end
  
protected

  # handle certain errors ourselves
  def handle_active_resource_errors
    @error = false
    begin
      yield
    rescue SocketError, ActiveResource::UnauthorizedAccess, URI::BadURIError => e
      @error = e
      render and return
    end
  end

end
