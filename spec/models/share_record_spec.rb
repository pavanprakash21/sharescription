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

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(share_record).to respond_to(:safe_toggle) }
    end

    context 'executes safe_toggle properly' do
      it 'changes the attribute from true to false and vice versa' do
        share_record = create :share_record
        expect(share_record.safe_toggle(:shared)).to eq true
      end
    end
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it { expect(ShareRecord).to respond_to(:shared_with) }
    end

    context 'executes shared_with properly' do
      it 'scopes accurately' do
        shareable = create :doctor
        share_record = create :share_record, shareable: shareable
        share_record.reload
        expect(ShareRecord.shared_with(shareable)).to eq [share_record]
      end
    end
  end
end
