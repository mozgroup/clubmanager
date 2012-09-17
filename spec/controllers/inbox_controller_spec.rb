require 'spec_helper'

describe InboxController do

  describe "GET 'index' with no authentication" do
    it "should redirect to login" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "GET 'index' with authentication" do

    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "should be successful" do
      get 'index'
      response.should be_success
    end

#   it { assigns(:inbox).should Envelope.inbox.belongs_to_user(@user).order(:sent_at) }
  end
end
