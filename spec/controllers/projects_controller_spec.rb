require 'spec_helper'

describe ProjectsController do

  describe "GET 'search' with no authentication" do
    it "should redirect to login" do
      get 'search'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "GET 'search'" do

    it "should be successful" do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get 'search'
    # response.should be_success
    end

  end

end
