require 'rails_helper'

RSpec.describe Api::PasswordResetController, :type => :controller do
  let(:user) { Fabricate(:user) }

  describe 'POST create' do
    context 'with valid email' do
      before { post :create, user: { email: user.email } }

      it 'returns :ok' do
        expect(response.response_code).to eq(200)
      end

      it 'sends a password reset email through devise' do
        expect(ActionMailer::Base.deliveries.empty?).to eq(false)
        expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
      end
    end
  end
end
