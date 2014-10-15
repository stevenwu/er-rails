require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  let(:user) { Fabricate(:user) }

  it 'send welcome email' do
    welcome_email = UserMailer.welcome_user(user).deliver

    expect(ActionMailer::Base.deliveries.empty?).to eq(false)

    expect(welcome_email.from).to eq(['hello@stamford.com'])
    expect(welcome_email.to).to eq([user.email])
  end
end
