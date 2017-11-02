# frozen_string_literal: true

describe User, type: :model do
  let(:user) { build :user }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:name) }
    # Uniqueness Validations
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    # Length Validations
    it { expect(user).to validate_length_of(:name).is_at_least(4).is_at_most(60) }
    # Format Validations
    it { expect(user).to allow_value('Ramesh Suresh').for(:name) }
    it { expect(user).to allow_value('asd@asd.com').for(:email) }
    it { expect(user).not_to allow_value('123').for(:name) }
    it { expect(user).not_to allow_value('123Abc').for(:name) }
    it { expect(user).not_to allow_value('Abc@ Asd').for(:name) }
  end

  context 'ActiveRecord Associations' do
    it { expect(user).to have_many(:medical_records) }
  end

  describe 'ActiveRecord databases' do
    it { expect(user).to have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
    it { expect(user).to have_db_column(:name).of_type(:string).with_options(null: false, default: '') }
    it { expect(user).to have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
  end
end
