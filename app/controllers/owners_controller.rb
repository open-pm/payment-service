# frozen_string_literal: true

# Owner's REST API. Here are all actions for Owner entity
class OwnersController < ApplicationController
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  before_action :set_owner, only: %i[show update destroy]

  # GET /owners
  def index
    @owners = Owner.all
    json_response(@owners)
  end

  # GET /owners/:id
  def show
    json_response(@owner)
  end

  # POST /owners
  def create
    @owner = Owner.create!(owner_params)
    json_response(@owner, :created)
  rescue ActiveRecord::RecordInvalid, ArgumentError, ActionController::ParameterMissing
    head :bad_request
  end

  # PUT /owners/:id
  def update
    @owner = Owner.update(owner_params)

    head :no_content
  end

  def destroy
    @owner.destroy
    head :no_content
  end

  private

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.permit(:legal_name, document_attributes: %i[document_type number],
                               contact_infos_attributes: %i[contact_type info],
                               address_attributes: %i[street number zip_code])
  end
end
