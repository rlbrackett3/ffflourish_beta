Fabricator(:user) do
  first_name            "Bair"
  last_name             "DeBair"
  email { Fabricate.sequence(:email) { |n| "test#{n}@user.com" } }
  email_confirmation    :email
  password              "foobar"
  password_confirmation :password
  created_at            Time.now
  updated_at            Time.now
end
