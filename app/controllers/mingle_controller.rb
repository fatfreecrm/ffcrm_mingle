class MingleController < ApplicationController
  before_filter :require_user

  # GET /mingle
  #----------------------------------------------------------------------------
  def index
    @mingles = Mingle.all
  end

  # GET /mingle/new
  #----------------------------------------------------------------------------
  def new
    begin
      @mingle = Mingle.new(params[:mingle])
      @error = false
    rescue ActiveResource::UnauthorizedAccess
      @error = true
    end
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
end
