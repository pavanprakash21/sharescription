# frozen_string_literal: true

describe User do
  it 'displays data of shared records' do
    user = create(:user)
    user_sign_in(user.email, user.password)
    click_on 'Shared Records', match: :first
    expect(page.body).to have_content('Your Shared Records')
  end
end
