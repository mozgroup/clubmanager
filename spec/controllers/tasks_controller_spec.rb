require 'spec_helper'

describe TasksController do

  describe "GET 'index' without authentication" do
    it "should redirect to login when not authenticated" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "GET 'index' authenticated" do
    let!(:c1) { FactoryGirl.create(:context, name: 'ZZZ') }
    let!(:c2) { FactoryGirl.create(:context, name: 'AAA') }
    let!(:c3) { FactoryGirl.create(:context, name: 'GGG') }
    before do
      sign_in FactoryGirl.create(:user)
      get 'index'
    end

    it "should be successful when authenticated" do
      response.should be_success
    end

    it "should display all contexts" do
      assigns(:contexts).should eq(Context.by_name)
    end

    it "should have the contexts ordered by name" do
      assigns(:contexts).should eq([c2, c3, c1])
    end
  end

end
