# frozen_string_literal: true

describe ShareRecordsController, type: :controller do
  describe 'GET #index' do
    it 'serves success without login' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'serves success with user login' do
      user = build :user
      sign_in(user)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'serves success with doctor login' do
      doctor = build :doctor
      sign_in(doctor)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'serves success with pharmacist login' do
      pharmacist = build :pharmacist
      sign_in(pharmacist)
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
