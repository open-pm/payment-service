# frozen_string_literal: true

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
    @owner = Owner.create!(create_owner_params)
    json_response(@owner, :created)
  end

  # PUT /owners/:id
  def update
    @owner = Owner.update!(update_owner_params)

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

  def create_owner_params
    params.require(:legal_name, contact_infos_attributes: [], document_attributes: [],
                                address_attributes: [])
  end

  def update_owner_params
    params.permit(:legal_name, contact_infos_attributes: %i[type info],
                               document_attributes: %i[type number],
                               address_attributes: %i[street number zip_code])
  end
end
