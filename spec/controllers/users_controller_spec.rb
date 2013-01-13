require 'spec_helper'

describe UsersController do

  let!(:user) { FactoryGirl.create(:user, roles: ['associate']) }
  let!(:another_user) { FactoryGirl.create(:user, roles: ['associate']) }

  def valid_attributes
    {
      first_name: 'John',
      last_name: 'Smith'
    }
  end

  before(:each) do
    sign_in user
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, { id: user.to_param }
      assigns(:user).should eq(user)
    end

    it "should not allow access to another user" do
      expect { get :show, { id: another_user.to_param } }.to raise_error(Exception)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, { id: user.to_param }
      assigns(:user).should eq(user)
    end

    it "should not allow access to another user" do
      expect { get :edit, { id: another_user.to_param } }.to raise_error(Exception)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => user.to_param, :user => {'these' => 'params'}}
      end

      it "assigns the requested user as @user" do
        put :update, {:id => user.to_param, :user => valid_attributes}
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        put :update, {:id => user.to_param, :user => valid_attributes}
        response.should redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {}}
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "user 'search'" do
    let!(:srch_usr) { FactoryGirl.create(:user, first_name: 'Bob', last_name: 'Jones') }
    it "shoud return an json response" do
      xhr :get, :search, { term: 'jo' }
      response.code.should == "200"
    end
  end

  describe "GET change_password" do
    it "assigns the requested user to @user" do
      get :change_password, { id: user.to_param }
      assigns(:user).should eq(user)
    end

    it "should not allow access to another user" do
      expect { get :change_password, { id: another_user.to_param } }.to raise_error(Exception)
    end
  end
end
