require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "正常系" do
    it 'should get root' do
      get static_pages_home_url
      expect(response).to have_http_status(:success)
    end

    it 'should get home' do
      get static_pages_home_url
      expect(response).to have_http_status(:success)
    end

    it 'should get help' do
      get static_pages_help_url
      expect(response).to have_http_status(:success)
    end

    it 'should get about' do
      get static_pages_about_url
      expect(response).to have_http_status(:success)
    end
  end
end
