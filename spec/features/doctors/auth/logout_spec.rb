# frozen_string_literal: true

describe Doctor do
  it 'successfully' do
    doctor = create(:doctor)
    doctor_sign_in(doctor.email, doctor.password)
    click_on 'Log Out', match: :first
    expect(page).to have_current_path(root_path)
  end
end
