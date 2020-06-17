RSpec.describe 'PUT /api/offers/:id', type: :request do
  let(:requester) { create(:user) }
  let(:requester_credentials) {requester.create_new_auth_token}
  let(:requester_headers) {{ HTTP_ACCEPT: 'application/json' }.merge!(requester_credentials)}
  let(:request) { create(:request, requester_id: requester.id) }

  let(:helper) { create(:user) }
  let(:offer) { create(:offer, status: 'pending', request_id: request.id, helper_id: helper.id)}

  describe 'requester accepts offer' do
    before do
      put "/api/offers/#{offer.id}",
           headers: requester_headers,
           params: { activity: 'approved'}
    end

    it 'has 200 response' do
      expect(response).to have_http_status 200
    end

    it 'responds offer message' do
      expect(response_json['message']).to eq 'Helper is set'
    end
  end
end