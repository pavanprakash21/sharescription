# frozen_string_literal: true

describe Prescription, type: :model do
  let(:prescrip) { build :prescription }

  it 'has a valid factory' do
    expect(build(:prescription)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(prescrip).to validate_presence_of(:name) }
    it { expect(prescrip).to validate_presence_of(:dosage) }
    it { expect(prescrip).to validate_presence_of(:dosage_unit) }
    it { expect(prescrip).to validate_presence_of(:time) }
    # Uniqueness Validations
    it { expect(prescrip).to validate_uniqueness_of(:name).scoped_to(:medical_record_id) }
    # Length Validations
    it { expect(prescrip).to validate_length_of(:name).is_at_least(3).is_at_most(100) }
  end

  context 'ActiveRecord Associations' do
    it { expect(prescrip).to belong_to(:medical_record) }
  end

  describe 'ActiveRecord databases' do
    it { expect(prescrip).to have_db_column(:name).of_type(:string).with_options(null: false, default: '') }
    it { expect(prescrip).to have_db_column(:dosage).of_type(:string).with_options(null: false, default: '') }
    it { expect(prescrip).to have_db_column(:dosage_unit).of_type(:string).with_options(null: false, default: '') }
    it { expect(prescrip).to have_db_column(:time).of_type(:string).with_options(null: false, default: '') }
    it { expect(prescrip).to have_db_column(:morning).of_type(:boolean).with_options(null: false, default: false) }
    it { expect(prescrip).to have_db_column(:afternoon).of_type(:boolean).with_options(null: false, default: false) }
    it { expect(prescrip).to have_db_column(:night).of_type(:boolean).with_options(null: false, default: false) }
    it { expect(prescrip).to have_db_column(:medical_record_id).of_type(:uuid) }
  end
end
