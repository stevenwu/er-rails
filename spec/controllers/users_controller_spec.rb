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
  end
end
