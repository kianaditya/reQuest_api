# frozen_string_literal: true

RSpec.describe 'GET /api/offers/:id', type: :request do
  let(:requester) { create(:user) }
  let(:request) { create(:request, requester_id: requester.id) }

  let(:helper) { create(:user) }
  let(:helper_credentials) { helper.create_new_auth_token }
  let(:helper_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(helper_credentials) }

  let(:offer) { 
    create(:offer, message: 'I can help you', helper_id: helper.id, request_id: request.id) 
  }

  describe 'with valid params and headers' do
    before do
      get `/api/offers/#{offer.id}`,
           headers: helper_headers,
           params: { request_id: request.id }
    end

    it 'has 200 response' do
      expect(response).to have_http_status 200
    end

    it 'responds offer message' do
      expect(response_json['offer']['message']).to eq 'I can help you'
    end

    it 'responds offer status' do
      expect(response_json['offer']['status']).to eq 'pending'
    end
  end

  #   describe 'reQuest is declined' do
  #     before do
  #       get "/api/offers/#{request.id}", params: { activity: 'decline' }, headers: headers
  #     end

  #     it 'has 200 response' do
  #       expect(response).to have_http_status 200
  #     end

  #     it 'responds with a message' do
  #       expect(response_json['message']).to eq 'Sorry, your offer has been declined!'
  #     end
  #   end
  # end
end
