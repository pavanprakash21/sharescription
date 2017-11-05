# frozen_string_literal: true

describe Pharmacist do
  it 'successfully' do
    pharmacist = create(:pharmacist)
    pharmacist_sign_in(pharmacist.email, pharmacist.password)
    click_on 'Log Out', match: :first
    expect(page).to have_current_path(root_path)
  end
end
