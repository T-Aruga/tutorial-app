require 'rails_helper'

RSpec.describe "Users", type: :request do

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end

  describe "正常系" do

    before do
      @user = create(:user)
    end

    it 'should get new' do
      get login_path
      expect(response).to have_http_status(:ok)
    end

    it "login with valid information" do
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to user_path(@user)
      expect(is_logged_in?).to be_truthy
    end

    it "login with valid information/invalid password" do
      post login_path, params: { session: { email: @user.email, password: 'invalid' } }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Invalid email/password combination'
      expect(is_logged_in?).to be_falsey
    end

    it "login with valid information/invalid password" do
      post login_path, params: { session: { email: @user.email, password: 'password' } }
      delete logout_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsey
    end
  end
end
