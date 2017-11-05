# frozen_string_literal: true

describe Pharmacist do
  it 'displays data of shared records' do
    pharmacist = create(:pharmacist)
    pharmacist_sign_in(pharmacist.email, pharmacist.password)
    click_on 'Shared Records', match: :first
    expect(page.body).to have_content('Your Shared Records')
  end
end
