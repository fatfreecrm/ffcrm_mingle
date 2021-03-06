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
    @mingle = Mingle.create(params[:mingle])
    flash[:error] = @mingle.errors.full_messages if !@mingle.new_record? # failed to save card
  end

protected

  # handle certain errors ourselves
  def handle_active_resource_errors
    @error = false
    begin
      yield
    rescue Exception => e
      @error = e
      Rails.logger.info(e)
      render and return
    end
  end

end
