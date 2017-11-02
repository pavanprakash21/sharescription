# frozen_string_literal: true

describe Pharmacist, type: :model do
  let(:pharmacist) { build :pharmacist }

  it 'has a valid factory' do
    expect(build(:pharmacist)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(pharmacist).to validate_presence_of(:email) }
    it { expect(pharmacist).to validate_presence_of(:name) }
    # Uniqueness Validations
    it { expect(pharmacist).to validate_uniqueness_of(:email).case_insensitive }
    # Length Validations
    it { expect(pharmacist).to validate_length_of(:name).is_at_least(4).is_at_most(60) }
    # Format Validations
    it { expect(pharmacist).to allow_value('Ramesh Suresh').for(:name) }
    it { expect(pharmacist).to allow_value('asd@asd.com').for(:email) }
    it { expect(pharmacist).not_to allow_value('123').for(:name) }
    it { expect(pharmacist).not_to allow_value('123Abc').for(:name) }
    it { expect(pharmacist).not_to allow_value('Abc@ Asd').for(:name) }
  end

  describe 'ActiveRecord databases' do
    it { expect(pharmacist).to have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
    it { expect(pharmacist).to have_db_column(:name).of_type(:string).with_options(null: false, default: '') }
    it do
      expect(pharmacist).to have_db_column(:encrypted_password).of_type(:string)
                                                               .with_options(null: false, default: '')
    end
  end
end
