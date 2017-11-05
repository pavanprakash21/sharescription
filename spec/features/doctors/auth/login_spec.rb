# frozen_string_literal: true

describe Doctor do
  it 'can sign in with valid credentials' do
    doctor = create(:doctor)
    doctor_sign_in(doctor.email, doctor.password)
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  it 'cannot sign in if not registered' do
    doctor_sign_in('test@example.com', 'please1231@#')
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong email' do
    doctor = create(:doctor)
    doctor_sign_in('invalid@email.com', doctor.password)
    expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'Email'
  end

  it 'cannot sign in with wrong password' do
    doctor = create(:doctor)
    doctor_sign_in(doctor.email, 'invalidpass')
    expect(page).to have_content I18n.t 'devise.failure.invalid',
      authentication_keys: 'Email'
  end
end
