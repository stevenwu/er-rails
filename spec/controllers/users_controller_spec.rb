require 'rails_helper'

describe Api::UsersController do
  let(:user) { Fabricate(:user) }

  describe 'GET index' do
    before { get :index }

    it 'returns :ok' do
      expect(response.response_code).to eq(200)
    end
  end

  describe 'GET show' do
    before { get :show, id: user.id }

    it 'returns :ok' do
      expect(response.response_code).to eq(200)
    end
  end

  describe 'PUT update' do
    context 'with wrong credentials' do
      before { put :update, id: user.id, email: 'new_email@example.com' }

      it 'returns :unauthorized' do
        expect(response.response_code).to eq(401)
      end
    end

    context 'with correct credentials' do
      before do
        user.ensure_authentication_token
        put :update, id: user.id, auth_token: user.authentication_token, user: {email: 'new_email@example.com' }
      end

      it 'returns :ok' do
        expect(response.response_code).to eq(200)
      end
    end

    context 'can change passwords' do
      before do
        put :update_password, user: { reset_password_token: user.reset_password_token, password: 'new_pass', password_confirmation: 'new_pass'}
      end

      it 'returns :ok' do
        expect(response.response_code).to eq(200)
      end
    end
  end

  it 'will send welcome email on user sign up' do
    user = Fabricate.build(:user)

    expect do
      post :create, user: { email: user.email, password: user.password, password_confirmation: user.password, auth_token: user.authentication_token }
    end.to change{ActionMailer::Base.deliveries.size}.by(1)
  end
end
