require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "正常系" do
    it 'should get new' do
      get signup_path
      expect(response).to have_http_status(:ok)
    end

    it "valid signup information" do
      expect{ post users_path, params: { user: { name:  "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
      }.to change{
        User.count
      }.from(0).to(1)
      expect(response).to have_http_status(:found)
    end
  end

  describe '異常系' do
    it "invalid signup information" do
      expect{ post users_path, params: { user: { name:  "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
      }.not_to change{
        User.count
      }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'prohibited this user from being saved'
    end
  end
end
