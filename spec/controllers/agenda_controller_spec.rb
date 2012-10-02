require 'spec_helper'

describe AgendaController do

  describe "GET 'index'" do
    it "should redirect to login when not authenticated" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end

    it "should be successful when authenticated" do
      sign_in FactoryGirl.create(:user)
      get 'index'
      response.should be_success
    end
  end

end
