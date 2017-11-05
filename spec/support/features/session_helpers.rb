# frozen_string_literal: true

module SessionHelpers
  def user_sign_up(name, email, password)
    visit new_user_registration_path
    fill_in 'user[name]', with: name
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password, match: :prefer_exact
    # click_button 'Sign up'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end

  def user_sign_in(email, password)
    visit new_user_session_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    # click_button 'Sign in'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end

  def doctor_sign_up(name, email, password)
    visit new_doctor_registration_path
    fill_in 'doctor[name]', with: name
    fill_in 'doctor[email]', with: email
    fill_in 'doctor[password]', with: password, match: :prefer_exact
    # click_button 'Sign up'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end

  def doctor_sign_in(email, password)
    visit new_doctor_session_path
    fill_in 'doctor[email]', with: email
    fill_in 'doctor[password]', with: password
    # click_button 'Sign in'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end

  def pharmacist_sign_up(name, email, password)
    visit new_pharmacist_registration_path
    fill_in 'pharmacist[name]', with: name
    fill_in 'pharmacist[email]', with: email
    fill_in 'pharmacist[password]', with: password, match: :prefer_exact
    # click_button 'Sign up'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end

  def pharmacist_sign_in(email, password)
    visit new_pharmacist_session_path
    fill_in 'pharmacist[email]', with: email
    fill_in 'pharmacist[password]', with: password
    # click_button 'Sign in'
    find(:xpath, "//input[contains(@name, 'commit')]").click
  end
end
