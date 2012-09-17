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
      FactoryGirl.create_list(:envelope, 5, recipient: @user)
      sign_in @user
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end

    it " should have proper inbox items" do
      assigns(:inbox).should_not be_nil
    end

    it "should have the number of unread envelopes" do
      assigns(:unread_count).should_not be_nil
    end

    it "should have the proper trashed envelopes" do
      assigns(:trash).should_not be_nil
    end

    it "should have the proper sent messages" do
      assigns(:sent).should_not be_nil
    end

    it "should have the proper drafts" do
      assigns(:drafts).should_not be_nil
    end
  end
end
