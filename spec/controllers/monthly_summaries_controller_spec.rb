require 'spec_helper'

describe MonthlySummariesController do

  let!(:user) { FactoryGirl.create(:user, roles: ['admin']) }
  let!(:club) {FactoryGirl.create(:club) }

  before(:each) do
    sign_in user
  end
  # This should return the minimal set of attributes required to create a valid
  # MonthlySummary. As you add validations to MonthlySummary, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { club_id: club.id,
      month: Time.zone.now,
      business_days_in_month: 31,
      membership_goal: 1000,
      training_goal: 1000,
      juice_bar_goal: 1000,
      nursery_goal: 100,
      membership_draft_expected: 1000,
      training_draft_expected: 1000
    }
  end

  describe "GET index" do
    it "assigns all monthly_summaries as @monthly_summaries" do
      monthly_summary = MonthlySummary.create! valid_attributes
      get :index
      assigns(:monthly_summaries).should eq([monthly_summary])
    end
  end

  describe "GET show" do
    it "assigns the requested monthly_summary as @monthly_summary" do
      monthly_summary = MonthlySummary.create! valid_attributes
      get :show, {:id => monthly_summary.to_param}
      assigns(:monthly_summary).should eq(monthly_summary)
    end
  end

  describe "GET new" do
    it "assigns a new monthly_summary as @monthly_summary" do
      get :new
      assigns(:monthly_summary).should be_a_new(MonthlySummary)
    end
  end

  describe "GET edit" do
    it "assigns the requested monthly_summary as @monthly_summary" do
      monthly_summary = MonthlySummary.create! valid_attributes
      get :edit, {:id => monthly_summary.to_param}
      assigns(:monthly_summary).should eq(monthly_summary)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new MonthlySummary" do
        expect {
          post :create, {:monthly_summary => valid_attributes}
        }.to change(MonthlySummary, :count).by(1)
      end

      it "assigns a newly created monthly_summary as @monthly_summary" do
        post :create, {:monthly_summary => valid_attributes}
        assigns(:monthly_summary).should be_a(MonthlySummary)
        assigns(:monthly_summary).should be_persisted
      end

      it "redirects to the created monthly_summary" do
        post :create, {:monthly_summary => valid_attributes}
        response.should redirect_to(MonthlySummary.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved monthly_summary as @monthly_summary" do
        # Trigger the behavior that occurs when invalid params are submitted
        MonthlySummary.any_instance.stub(:save).and_return(false)
        post :create, {:monthly_summary => {}}
        assigns(:monthly_summary).should be_a_new(MonthlySummary)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MonthlySummary.any_instance.stub(:save).and_return(false)
        post :create, {:monthly_summary => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested monthly_summary" do
        monthly_summary = MonthlySummary.create! valid_attributes
        # Assuming there are no other monthly_summaries in the database, this
        # specifies that the MonthlySummary created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        MonthlySummary.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => monthly_summary.to_param, :monthly_summary => {'these' => 'params'}}
      end

      it "assigns the requested monthly_summary as @monthly_summary" do
        monthly_summary = MonthlySummary.create! valid_attributes
        put :update, {:id => monthly_summary.to_param, :monthly_summary => valid_attributes}
        assigns(:monthly_summary).should eq(monthly_summary)
      end

      it "redirects to the monthly_summary" do
        monthly_summary = MonthlySummary.create! valid_attributes
        put :update, {:id => monthly_summary.to_param, :monthly_summary => valid_attributes}
        response.should redirect_to(monthly_summary)
      end
    end

    describe "with invalid params" do
      it "assigns the monthly_summary as @monthly_summary" do
        monthly_summary = MonthlySummary.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MonthlySummary.any_instance.stub(:save).and_return(false)
        put :update, {:id => monthly_summary.to_param, :monthly_summary => {}}
        assigns(:monthly_summary).should eq(monthly_summary)
      end

      it "re-renders the 'edit' template" do
        monthly_summary = MonthlySummary.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MonthlySummary.any_instance.stub(:save).and_return(false)
        put :update, {:id => monthly_summary.to_param, :monthly_summary => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested monthly_summary" do
      monthly_summary = MonthlySummary.create! valid_attributes
      expect {
        delete :destroy, {:id => monthly_summary.to_param}
      }.to change(MonthlySummary, :count).by(-1)
    end

    it "redirects to the monthly_summaries list" do
      monthly_summary = MonthlySummary.create! valid_attributes
      delete :destroy, {:id => monthly_summary.to_param}
      response.should redirect_to(monthly_summaries_url)
    end
  end

end
