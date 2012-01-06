class FatFreeCrmMingle::MingleController < ApplicationController
  before_filter :require_user

  # GET /mingle
  #----------------------------------------------------------------------------
  def index
    @mingles = FatFreeCrmMingle::Mingle.all
  end

  # GET /mingle/new
  #----------------------------------------------------------------------------
  def new
    @mingle = FatFreeCrmMingle::Mingle.new(params[:mingle])
  end

  # POST /mingle
  #----------------------------------------------------------------------------
  def create
    @mingle = FatFreeCrmMingle::Mingle.new(params[:mingle])
    @mingle.properties << {'name' => 'owner', 'value' => @current_user.username}
    if @mingle.save
      @mingle = FatFreeCrmMingle::Mingle.all(:conditions => ["number = #{@mingle.number}"]).first
    end
  end
end
