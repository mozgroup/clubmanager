require 'spec_helper'

describe TasksController do

  describe "GET 'index' without authentication" do
    it "should redirect to login when not authenticated" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "GET 'index' authenticated" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:t1) { FactoryGirl.create(:task) }
    let!(:t2) { FactoryGirl.create(:task) }
    let!(:t3) { FactoryGirl.create(:task) }

    before do
      t1.assignee = user
      t1.save!
      t2.assignee = user
      t2.save!

      sign_in user
      get 'index'
    end

    it "should be successful when authenticated" do
      response.should be_success
    end

    it "should display all of the users tasks" do
      assigns(:tasks).size.should eq(2)
    end
  end

end
