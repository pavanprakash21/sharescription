# frozen_string_literal: true

describe Pharmacist do
  it 'signs up successfully with valid email and password' do
    doctor_sign_up('awesome doctor', 'test@example.com', 'please123')
    expect(page).to have_content 'Log Out'
  end

  it 'cannot sign up with invalid email address' do
    doctor_sign_up('awesome doctor', 'bogus', 'please123')
    expect(page).to have_content 'is invalid'
  end

  it 'cannot sign up without password' do
    doctor_sign_up('awesome doctor', 'test@example.com', '')
    expect(page).to have_content "can't be blank"
  end

  it 'cannot sign up without name' do
    doctor_sign_up('', 'test@example.com', 'pleas')
    expect(page).to have_content "can't be blank"
  end

  it 'cannot sign up with a short password' do
    doctor_sign_up('awesome doctor', 'test@example.com', 'pleas')
    expect(page).to have_content 'is too short'
  end
end
