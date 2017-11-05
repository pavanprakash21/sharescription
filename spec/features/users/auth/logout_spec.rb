# frozen_string_literal: true

describe User do
  it 'successfully' do
    user = create(:user)
    user_sign_in(user.email, user.password)
    click_on 'Log Out', match: :first
    expect(page).to have_current_path(root_path)
  end
end
