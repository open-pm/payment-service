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
                                          number: Faker::Number.number(11) },
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
                                   document_attributes: { document_type: %w(CPF CNPJ).sample, number: Faker::Number.number(10)},
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
                                  contact_infos_attributes: [], document_attributes: { document_type: %w(CPF CNPJ).sample, number: Faker::Number.number(11)} } 
          expect(response).to have_http_status(400)
        end
      end
    
      context  'when valid params' do
        before do
          post '/owners', params:  {legal_name: Faker::StarWars.character, 
                                    document_attributes: { document_type: %w(CPF CNPJ).sample, 
                                                           number: Faker::Number.number(11)},
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

    describe "PUT /owners/:id" do
      let(:owner) {owners.last}

      context 'passing legal_name attribute' do
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

      context 'passing documment attributes' do
        let(:new_document) { {document_type: %w(CPF CNPJ).sample, number: Faker::Number.number(11)} }
        let(:owner){ owners.last }
        before{ put "/owners/#{owner.id}", params: { document_attributes: new_document} }
        let(:owner_serializer) { OwnerSerializer.new(owner) }

        it 'returns 204 No Content' do
          expect(response).to have_http_status(204)
        end

        it 'updates the document in resource' do
          get "/owners/#{owner.id}"
          expect(json['document']['document_type']).to eq(new_document[:document_type])
          expect(json['document']['number']).to eq(new_document[:number])

          # We are not testing the document_type update because it is a random choise in a list, then 
          # Testing it could cause tests failures.
          expect(json['document']['number']).not_to eq(owner_serializer.serializable_hash[:address][:number])
        end

        it 'doesn\'t other properties' do
          get "/owners/#{owner.id}"
          expect(json['legal_name']).to eq(owner.legal_name)
          expect(json['contact_infos'].map{ |item|  item.symbolize_keys } ).to eq(owner_serializer.serializable_hash[:contact_infos])
          expect(json['address'].symbolize_keys  ).to eq(owner_serializer.serializable_hash[:address])
          
        end
      end
    end

      context 'passing contact_infos attributes' do
        let(:new_contact_infos) do
              [
                {contact_type: %w(email cell_phone land_number).sample, 
                 info: Faker::Internet.email },
                {contact_type: %w(email cell_phone land_number).sample, 
                 info: Faker::Internet.email }
              ]
        end
        let(:owner){ owners.last }
        let(:owner_serializer) { OwnerSerializer.new(owner) }

        context 'should' do
          before { put "/owners/#{owner.id}", params: { contact_infos_attributes: new_contact_infos } }

          it 'return 204 No Content' do
            expect(response).to have_http_status(204)
          end

          it 'update the contact_infos values' do
            get "/owners/#{owner.id}"
            expect(json['contact_infos'].map{ |item| item.symbolize_keys } ).to eq(new_contact_infos)
            expect(json['contact_infos'].map{ |item| item.symbolize_keys} ).not_to eq(owner_serializer.serializable_hash[:contact_infos])
          end

          it 'not update the other properties' do
            get "/owners/#{owner.id}"
            expect(json['legal_name']).to eq(owner.legal_name)
            expect(json['address'].symbolize_keys  ).to eq(owner_serializer.serializable_hash[:address])
            expect(json['document'].symbolize_keys  ).to eq(owner_serializer.serializable_hash[:document])
          end

        end

      end

end
