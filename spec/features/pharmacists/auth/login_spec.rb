# frozen_string_literal: true

describe Pharmacist do
  it 'can sign in with valid credentials' do
    pharmacist = create(:pharmacist)
    pharmacist_sign_in(pharmacist.email, pharmacist.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  it 'cannot sign in if not registered' do
    pharmacist_sign_in('test@example.com', 'please1231@#')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong email' do
    pharmacist = create(:pharmacist)
    pharmacist_sign_in('invalid@email.com', pharmacist.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong password' do
    pharmacist = create(:pharmacist)
    pharmacist_sign_in(pharmacist.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid',
      authentication_keys: 'Email'
  end
end
