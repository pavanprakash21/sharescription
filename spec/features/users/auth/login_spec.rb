# frozen_string_literal: true

describe User do
  it 'can sign in with valid credentials' do
    user = create(:user)
    user_sign_in(user.email, user.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  it 'cannot sign in if not registered' do
    user_sign_in('test@example.com', 'please1231@#')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong email' do
    user = create(:user)
    user_sign_in('invalid@email.com', user.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong password' do
    user = create(:user)
    user_sign_in(user.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid',
      authentication_keys: 'Email'
  end
end
