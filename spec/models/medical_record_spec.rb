# frozen_string_literal: true

describe MedicalRecord, type: :model do
  let(:medical_record) { build :medical_record }

  it 'has a valid factory' do
    expect(build(:medical_record)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(medical_record).to validate_presence_of(:name) }
    # Uniqueness Validations
    it { expect(medical_record).to validate_uniqueness_of(:name).scoped_to(:user_id) }
    # Length Validations
    it { expect(medical_record).to validate_length_of(:name).is_at_least(3).is_at_most(60) }
  end

  context 'ActiveRecord Associations' do
    it { expect(medical_record).to belong_to(:user) }
    it { expect(medical_record).to have_many(:prescriptions) }
  end

  describe 'ActiveRecord databases' do
    it { expect(medical_record).to have_db_column(:name).of_type(:string).with_options(null: false, default: '') }
    it { expect(medical_record).to have_db_column(:notes).of_type(:text) }
    it { expect(medical_record).to have_db_column(:user_id).of_type(:uuid) }
    it { expect(medical_record).to have_db_index(:name).unique(true) }
  end
end
