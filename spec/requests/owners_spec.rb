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
end
