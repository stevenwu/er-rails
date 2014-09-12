require 'rails_helper'

describe User do
  it 'should not save user without an email' do
    user = User.new
    expect(user.save).to be false
  end
end
