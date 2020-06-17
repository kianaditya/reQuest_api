RSpec.describe Offer, type: :model do
  describe 'database table' do
    it { is_expected.to have_db_column :message }
    it { is_expected.to have_db_column :request_id }
    it { is_expected.to have_db_column :helper_id }
  end

    it { is_expected.to have_db_column :status }
  describe 'relations' do
    it { is_expected.to belong_to :helper }
    it { is_expected.to belong_to :request }
  end

  describe 'factory' do
    it 'should be valid' do
      expect(create(:offer)).to be_valid
    end
  end
end
