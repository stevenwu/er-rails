require 'rails_helper'

describe User do
  it 'should not save user without an email' do
    user = User.new
    expect(user.save).to be false
  end

  it 'should have a default role of :user' do
    user = User.new(email: 'me@gmail.com', password: 'password')
    expect(user.user?).to be true
  end
end
