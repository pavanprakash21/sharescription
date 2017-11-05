# frozen_string_literal: true

describe User do
  it 'delete user created medical record' do
    # user = create(:user)
    # create :medical_record, user: user
    # user_sign_in(user.email, user.password)
    # find_and_click_delete
    # expect(page).to have_content 'Your medical record has been deleted'
    # pending 'try later'
  end
end

private

def find_and_click_delete
  click_on 'Your Medical Records', match: :first
  find(:xpath, "//i[@id='delete-icon']").click
end
