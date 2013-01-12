require 'spec_helper'

describe ChecklistsController do

  let!(:user) { FactoryGirl.create(:user, roles: ['admin']) }

  before(:each) { sign_in user }

  def valid_attributes
    {
      user_id: user.id,
      author_id: user.id,
      name: 'The Name',
      frequency: 'daily',
      days_of_week: ['1','2']
    }
  end

  describe "GET index" do
    it "assigns all checklists as @checklists" do
      checklist = Checklist.create! valid_attributes
      get :index
      assigns(:checklists).should eq([checklist])
    end
  end

  describe "GET show" do
    it "assigns the requested checklist as @checklist" do
      checklist = Checklist.create! valid_attributes
      get :show, {:id => checklist.to_param}
      assigns(:checklist).should eq(checklist)
    end
  end

  describe "GET new" do
    it "assigns a new checklist as @checklist" do
      get :new
      assigns(:checklist).should be_a_new(Checklist)
    end
  end

  describe "GET edit" do
    it "assigns the requested checklist as @checklist" do
      checklist = Checklist.create! valid_attributes
      get :edit, {:id => checklist.to_param}
      assigns(:checklist).should eq(checklist)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Checklist" do
        expect {
          post :create, {:checklist => valid_attributes}
        }.to change(Checklist, :count).by(1)
      end

      it "assigns a newly created checklist as @checklist" do
        post :create, {:checklist => valid_attributes}
        assigns(:checklist).should be_a(Checklist)
        assigns(:checklist).should be_persisted
      end

      it "redirects to the created checklist" do
        post :create, {:checklist => valid_attributes}
        response.should redirect_to(Checklist.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checklist as @checklist" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checklist.any_instance.stub(:save).and_return(false)
        post :create, {:checklist => {}}
        assigns(:checklist).should be_a_new(Checklist)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checklist.any_instance.stub(:save).and_return(false)
        post :create, {:checklist => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested checklist" do
        checklist = Checklist.create! valid_attributes
        # Assuming there are no other checklists in the database, this
        # specifies that the Checklist created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Checklist.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => checklist.to_param, :checklist => {'these' => 'params'}}
      end

      it "assigns the requested checklist as @checklist" do
        checklist = Checklist.create! valid_attributes
        put :update, {:id => checklist.to_param, :checklist => valid_attributes}
        assigns(:checklist).should eq(checklist)
      end

      it "redirects to the checklist" do
        checklist = Checklist.create! valid_attributes
        put :update, {:id => checklist.to_param, :checklist => valid_attributes}
        response.should redirect_to(checklist)
      end
    end

    describe "with invalid params" do
      it "assigns the checklist as @checklist" do
        checklist = Checklist.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Checklist.any_instance.stub(:save).and_return(false)
        put :update, {:id => checklist.to_param, :checklist => {}}
        assigns(:checklist).should eq(checklist)
      end

      it "re-renders the 'edit' template" do
        checklist = Checklist.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Checklist.any_instance.stub(:save).and_return(false)
        put :update, {:id => checklist.to_param, :checklist => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested checklist" do
      checklist = Checklist.create! valid_attributes
      expect {
        delete :destroy, {:id => checklist.to_param}
      }.to change(Checklist, :count).by(-1)
    end

    it "redirects to the checklists list" do
      checklist = Checklist.create! valid_attributes
      delete :destroy, {:id => checklist.to_param}
      response.should redirect_to(checklists_url)
    end
  end

end
