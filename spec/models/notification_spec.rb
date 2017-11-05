# frozen_string_literal: true

describe Notification, type: :model do
  let(:notification) { build :notification }

  it 'has a valid factory' do
    expect(build(:notification)).to be_valid
  end

  describe 'ActiveModel validations' do
    # Presence Validations
    it { expect(notification).to validate_presence_of(:action) }
  end

  context 'ActiveRecord Associations' do
    it { expect(notification).to belong_to(:sender) }
    it { expect(notification).to belong_to(:recepient) }
  end

  describe 'ActiveRecord databases' do
    it { expect(notification).to have_db_column(:action).of_type(:string).with_options(null: false, default: '') }
    it { expect(notification).to have_db_column(:sender_type).of_type(:string) }
    it { expect(notification).to have_db_column(:sender_id).of_type(:uuid) }
    it { expect(notification).to have_db_column(:recepient_type).of_type(:string) }
    it { expect(notification).to have_db_column(:recepient_id).of_type(:uuid) }
  end
end
