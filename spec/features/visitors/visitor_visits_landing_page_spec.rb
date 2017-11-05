# frozen_string_literal: true

describe 'Visitor visits home page', type: :feature do
  it 'successfully' do
    visit root_path
    expect(page).to have_content 'Sign Up'
  end
end
