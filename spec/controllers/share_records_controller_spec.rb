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

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:medical_record) { create :medical_record, user: user }
    let(:doctor) { create :doctor }

    it 'creates a shared record' do
      sign_in(user)
      post :create, xhr: true, params: share_record_params(medical_record, doctor, user)
      expect(response).to have_http_status(:success)
    end

    it 'renders proper message when bad params are given' do
      sign_in(user)
      post :create, xhr: true, params: invalid_share_record_params(medical_record, doctor, user)
      expect(JSON.parse(response.body)['message']).to eq 'This record has already been shared'
    end
  end

  describe 'POST #temp_revoke' do
    let(:user) { create(:user) }
    let(:share_record) { create :share_record, user: user }

    it 'toggles the shared status of a shared record' do
      sign_in(user)
      patch :temp_revoke, xhr: true, params: { id: share_record.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #permit' do
    let(:user) { create(:user) }
    let(:share_record) { create :share_record, user: user }

    it 'permits the shared status of a shared record' do
      sign_in(user)
      patch :permit, xhr: true, params: { id: share_record.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #destroy' do
    let(:user) { create(:user) }
    let(:share_record) { create :share_record, user: user }

    it 'permits the shared status of a shared record' do
      sign_in(user)
      delete :destroy, xhr: true, params: { id: share_record.id }
      expect(response.code).to eq '204'
    end
  end
end

private

def share_record_params(medical_record, shareable, user)
  {
    share_record: {
      medical_record_id: medical_record.id,
      shareable_type:    shareable.class.name,
      shareable_id:      shareable.id,
      user_id:           user.id,
      created_by:        user.id,
      action:            :granted
    }
  }
end

def invalid_share_record_params(medical_record, _shareable, _user)
  {
    share_record: { medical_record_id: medical_record.id }
  }
end
