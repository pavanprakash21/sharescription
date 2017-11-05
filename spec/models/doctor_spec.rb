# frozen_string_literal: true

describe Doctor, type: :model do
  let(:doctor) { build :doctor }

  it 'has a valid factory' do
    expect(build(:doctor)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(doctor).to validate_presence_of(:email) }
    it { expect(doctor).to validate_presence_of(:name) }
    # Uniqueness Validations
    it { expect(doctor).to validate_uniqueness_of(:email).case_insensitive }
    # Length Validations
    it { expect(doctor).to validate_length_of(:name).is_at_least(4).is_at_most(60) }
    # Format Validations
    it { expect(doctor).to allow_value('Ramesh Suresh').for(:name) }
    it { expect(doctor).to allow_value('asd@asd.com').for(:email) }
    it { expect(doctor).not_to allow_value('123').for(:name) }
    it { expect(doctor).not_to allow_value('123Abc').for(:name) }
    it { expect(doctor).not_to allow_value('Abc@ Asd').for(:name) }
  end

  describe 'ActiveRecord databases' do
    it { expect(doctor).to have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
    it { expect(doctor).to have_db_column(:name).of_type(:string).with_options(null: false, default: '') }
    it { expect(doctor).to have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(doctor).to respond_to(:send_devise_notification) }
    end
  end
end
