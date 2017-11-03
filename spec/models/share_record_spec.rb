# frozen_string_literal: true

describe ShareRecord, type: :model do
  let(:share_record) { build :share_record }

  it 'has a valid factory' do
    expect(build(:share_record)).to be_valid
  end

  context 'ActiveRecord Associations' do
    it { expect(share_record).to belong_to(:medical_record) }
    it { expect(share_record).to belong_to(:user) }
    it { expect(share_record).to belong_to(:shareable) }
  end

  describe 'ActiveRecord databases' do
    it { expect(share_record).to have_db_column(:shared).of_type(:boolean).with_options(null: false, default: false) }
    it { expect(share_record).to have_db_column(:shareable_type).of_type(:string) }
    it { expect(share_record).to have_db_column(:user_id).of_type(:uuid) }
    it { expect(share_record).to have_db_column(:medical_record_id).of_type(:uuid) }
    it { expect(share_record).to have_db_column(:shareable_id).of_type(:uuid) }
  end
end
