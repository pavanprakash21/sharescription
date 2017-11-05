# frozen_string_literal: true

# == Schema Information
#
# Table name: pharmacists
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(pharmacist).to respond_to(:send_devise_notification) }
    end
  end
end
