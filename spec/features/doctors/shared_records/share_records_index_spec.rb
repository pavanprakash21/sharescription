# frozen_string_literal: true

describe Doctor do
  it 'displays data of shared records' do
    doctor = create(:doctor)
    doctor_sign_in(doctor.email, doctor.password)
    click_on 'Shared Records', match: :first
    expect(page.body).to have_content('Your Shared Records')
  end
end
