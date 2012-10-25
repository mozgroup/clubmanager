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
    let!(:t1) { FactoryGirl.create(:task, assignee: user) }
    let!(:t2) { FactoryGirl.create(:task, assignee: user) }
    let!(:t3) { FactoryGirl.create(:task) }

    before do
      sign_in user
      get 'index'
    end

    it "should be successful when authenticated" do
      response.should be_success
    end

    it "should display all of the users tasks" do
      assigns(:tasks).size.should eq(2)
    end
#    it "should display all contexts" do
#      assigns(:contexts).should eq(Context.by_name)
#    end
#
#    it "should have the contexts ordered by name" do
#      assigns(:contexts).should eq([c2, c3, c1])
#    end
  end

end
