class MingleController < ApplicationController
  before_filter :require_user

  # GET /mingle
  #----------------------------------------------------------------------------
  def index
    conditions = if params[:contact_id]
      "CRMContact = #{params[:contact_id]}"
    elsif params[:account_id]
      "CRMOrganisation = #{params[:account_id]}"
    elsif params[:opportunity_id]
      "CRMOpportunity = #{params[:opportunity_id]}"
    end

    @mingles = Mingle.all(:conditions => conditions)
  end

  # POST /mingle
  #----------------------------------------------------------------------------
  def create
    @mingle = Mingle.create(params[:mingle])
  end
end
