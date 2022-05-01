# frozen_string_literal: true

class OrganizationAssociationsController < ApplicationController
  before_action :set_organization_association, only: :destroy

  # GET /organization_associations
  def index
    @organization_associations = OrganizationAssociation.all

    render json: @organization_associations
  end

  # POST /organization_associations
  def create
    @organization_association = OrganizationAssociation.new(organization_association_params)

    if @organization_association.save
      render json: @organization_association, status: :created, location: :organization_organization_associations
    else
      render json: @organization_association.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organization_associations/1
  def destroy
    @organization_association.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization_association
    @organization_association = OrganizationAssociation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def organization_association_params
    params.require(:invite).permit(:customer_id).merge(organization_id: params[:organization_id])
  end
end
