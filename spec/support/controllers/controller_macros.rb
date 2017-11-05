# frozen_string_literal: true

module ControllerMacros
  def login_doctor
    before do
      @request.env['devise.mapping'] = Devise.mappings[:doctor]
      doctor = create(:doctor)
      doctor.confirm!
      sign_in doctor
    end
  end

  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      user.confirm!
      sign_in user
    end
  end

  def login_pharmacist
    before do
      @request.env['devise.mapping'] = Devise.mappings[:pharmacist]
      pharmacist = create(:pharmacist)
      pharmacist.confirm!
      sign_in pharmacist
    end
  end
end
