# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe 'Owners API', type: :request do
  let!(:owners) { create_list(:owner, 10) }

  describe 'GET /owners' do
    before { get '/owners' }

    it 'returns owners' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns HTTP OK' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /owners/:id' do
    let(:owner_id) { owners.first.id }
    before { get "/owners/#{owner_id}" }

    context 'when the owner record exists' do
      it 'returns the owner' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(owner_id)
      end

      it 'returns HTTP OK' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the owner record does not exist' do
      let(:owner_id) { 100 }

      it 'returns HTTP NOT FOUND' do
        expect(response).to have_http_status(404)
      end
    end

    describe 'DELETE /owners/:id' do
      let(:owner_id) { owners.last.id }
      before {  delete "/owners/#{ owner_id}"}

      context "when owner is deleted" do

        it 'return sucess and no content' do
          expect(response).to have_http_status(204)
        end

        it 'doesnt exist anymore' do
          get "/owners/#{owner_id}"
          expect(response).to have_http_status(404)
        end

      end

    end
  end

    describe 'POST /owners' do
      context 'when invalid params' do
        
        it 'miss all returns Bad Request(400)' do
          post  '/owners', params: {}
          expect(response).to have_http_status(400)
        end

        it 'miss legal_name only' do
          post  '/owners', params: {contact_infos_attributes: [], 
                                    document_attributes: { 
                                          document_type: %w(CPF CNPJ).sample, 
                                          number: 12345},
                                  address_attributes: {
                                              street: Faker::Address.street_name,
                                              number: Faker::Address.building_number,
                                              zip_code:  Faker::Address.zip_code,
                                              complement: [nil, "", Faker::Address.secondary_address].sample  }
          }
          expect(response).to have_http_status(400)
        end

        it 'miss contact_infos_attributes' do
          post '/owners', params: {legal_name: Faker::StarWars.character, 
                                   document_attributes: { document_type: %w(CPF CNPJ).sample, number: 1234},
                                    address_attributes: {
                                              street: Faker::Address.street_name,
                                              number: Faker::Address.building_number,
                                              zip_code:  Faker::Address.zip_code,
                                              complement: [nil, "", Faker::Address.secondary_address].sample  }
          }
          expect(response).to have_http_status(400)
        end

        it 'miss document' do
          post '/owners', params: {legal_name: Faker::StarWars.character, 
                                   contact_infos_attributes: [],
            
                                    address_attributes: {
                                              street: Faker::Address.street_name,
                                              number: Faker::Address.building_number,
                                              zip_code:  Faker::Address.zip_code,
                                              complement: [nil, "", Faker::Address.secondary_address].sample  }
          }
          expect(response).to have_http_status(400)
        end
        
        it 'miss address_attributes_attribtues' do
          post '/owners', params: {legal_name: Faker::StarWars.character,
                                  contact_infos_attributes: [], document_attributes: { document_type: %w(CPF CNPJ).sample, number: 12345} } 
          expect(response).to have_http_status(400)
        end
      end
    
      context  'when valid params' do
        before do
          post '/owners', params:  {legal_name: Faker::StarWars.character, 
                                    document_attributes: { document_type: %w(CPF CNPJ).sample, 
                                                           number: 12345},
                                    contact_infos_attributes:  [{contact_type: %w(email cell_phone land_number).sample, 
                                                      info: Faker::Internet.email }],
                                    address_attributes: {
                                              street: Faker::Address.street_name,
                                              number: Faker::Address.building_number,
                                              zip_code:  Faker::Address.zip_code,
                                              complement: [nil, "", Faker::Address.secondary_address].sample  }

                                    }
        end

        it 'returns 201 OK' do
          expect(response).to have_http_status(201)
        end


      end

    end

    describe "PUT /owners" do
      let(:owner) {owners.last}

      context "Update legal_name" do
        let(:new_legal_name) {  'new_legal_name' }
        before { put "/owners/#{owner.id}", params: {legal_name: new_legal_name }}
        
        it  'returns 204 No Content' do
          expect(response).to have_http_status(204)
        end
        
        it 'updates the resource' do
          get "/owners/#{owner.id}"
          expect(json['legal_name']).to eq(new_legal_name)

        end

      end
      

    end


end
