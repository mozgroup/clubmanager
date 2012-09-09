require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST create" do

    context "with invalid user" do
      it "renders the new template and shows an error message" do
        post :create, email: '', password: ''
        flash.now[:error].should eq('Invalid email/password combination')
        response.should render_template :new
      end
    end

    context "with valid user" do
      before :each do
        @user = FactoryGirl.create(:user)
      end

      it "sets the current_user and the session" do
        post :create, email: @user.email, password: @user.password
        assigns(:current_user) == @user
        session[:remember_token].should eq(@user.remember_token)
      end

      it "redirects to the home page" do
        post :create, email: @user.email, password: @user.password
        response.should redirect_to root_path
      end
    end
  end

  describe "POST destroy" do
    before :each do
      @user = FactoryGirl.create(:user)
      post :create, email: @user.email, password: @user.password
    end

    it "removes the current user and session" do
      delete :destroy
      assigns(:current_user).should be(nil)
      session[:remember_token].should be(nil)
    end

    it "redirects to the login page" do
      delete :destroy
      response.should redirect_to signin_path
    end
  end
end
