require 'rails_helper'

describe Api::SessionsController do
  let(:user) { Fabricate(:user) }

  describe 'POST create' do
    context 'no params' do
      before { post :create }

      it 'returns :bad_request' do
        expect(response.response_code).to eq(400)
      end
    end

    context 'with wrong credentials' do
      before { post :create, email: user.email, password: '' }

      it 'returns :unauthorized' do
        expect(response.response_code).to eq(401)
      end
    end

    context 'with correct credentials' do
      before { post :create, email: user.email, password: user.password }
      subject { JSON.parse response.body }

      it { should include 'user_id' }
      it { should include 'auth_token' }

      it 'returns :created' do
        expect(response.response_code).to eq(201)
      end
    end
  end

  describe 'DELETE destroy' do
  end
end
