require 'rails_helper'

RSpec.describe Api::V1::SsoController, type: :controller do

  describe "GET #validate_launch" do
    it "returns http success" do
      get :validate_launch
      expect(response).to have_http_status(:success)
    end
  end

end
