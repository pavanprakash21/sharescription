# frozen_string_literal: true

describe User do
  it 'signs up successfully with valid email and password' do
    user_sign_up('awesome user', 'test@example.com', 'please123')
    expect(page).to have_content 'Log Out'
  end

  it 'cannot sign up with invalid email address' do
    user_sign_up('awesome user', 'bogus', 'please123')
    expect(page).to have_content 'is invalid'
  end

  it 'cannot sign up without password' do
    user_sign_up('awesome user', 'test@example.com', '')
    expect(page).to have_content "can't be blank"
  end

  it 'cannot sign up without name' do
    user_sign_up('', 'test@example.com', 'pleas')
    expect(page).to have_content "can't be blank"
  end

  it 'cannot sign up with a short password' do
    user_sign_up('awesome user', 'test@example.com', 'pleas')
    expect(page).to have_content 'is too short'
  end
end
