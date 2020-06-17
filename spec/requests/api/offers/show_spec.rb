# frozen_string_literal: true

RSpec.describe 'GET /api/offers/:id', type: :request do
  let(:requester) { create(:user) }
  let(:request) { create(:request, requester_id: requester.id) }

  let(:helper) { create(:user) }
  let(:helper_credentials) { helper.create_new_auth_token }
  let(:helper_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(helper_credentials) }

  

  describe 'with valid params and headers for pending request' do
    let(:offer) { 
      create(:offer, message: 'I can help you', helper_id: helper.id, request_id: request.id) 
    }
    before do
      get "/api/offers/#{offer.id}",
           headers: helper_headers
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

    it 'responds with offer status message' do
      expect(response_json['status_message']).to eq 'Your offer is pending'
    end
  end

  describe 'with valid params and headers for approved request' do
    let(:offer) { 
      create(:offer, status: 'approved', message: 'I can help you', helper_id: helper.id, request_id: request.id) 
    }
    before do
      get "/api/offers/#{offer.id}",
           headers: helper_headers
    end

    it 'has 200 response' do
      expect(response).to have_http_status 200
    end

    it 'responds offer message' do
      expect(response_json['offer']['message']).to eq 'I can help you'
    end

    it 'responds offer status' do
      expect(response_json['offer']['status']).to eq 'approved'
    end

    it 'responds with offer status message' do
      expect(response_json['status_message']).to eq 'Your offer has been accepted'
    end
  end

  describe 'with valid params and headers for declined request' do
    let(:offer) { 
      create(:offer, status: 'declined', message: 'I can help you', helper_id: helper.id, request_id: request.id) 
    }
    before do
      get "/api/offers/#{offer.id}",
           headers: helper_headers
    end

    it 'has 200 response' do
      expect(response).to have_http_status 200
    end

    it 'responds offer message' do
      expect(response_json['offer']['message']).to eq 'I can help you'
    end

    it 'responds offer status' do
      expect(response_json['offer']['status']).to eq 'declined'
    end

    it 'responds with offer status message' do
      expect(response_json['status_message']).to eq 'Your offer has been declined'
    end
  end
end
