Fabricator(:user) do
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  reset_password_token { SecureRandom.urlsafe_base64 }
end
