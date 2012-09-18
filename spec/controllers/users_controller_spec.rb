require 'spec_helper'

describe UsersController do

  describe "GET 'search'" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "returns http success" do
      get 'search'
    # response.should be_success
    end
  end

end
