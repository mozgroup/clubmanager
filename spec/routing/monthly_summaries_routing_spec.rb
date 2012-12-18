require "spec_helper"

describe MonthlySummariesController do
  describe "routing" do

    it "routes to #index" do
      get("/monthly_summaries").should route_to("monthly_summaries#index")
    end

    it "routes to #new" do
      get("/monthly_summaries/new").should route_to("monthly_summaries#new")
    end

    it "routes to #show" do
      get("/monthly_summaries/1").should route_to("monthly_summaries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/monthly_summaries/1/edit").should route_to("monthly_summaries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/monthly_summaries").should route_to("monthly_summaries#create")
    end

    it "routes to #update" do
      put("/monthly_summaries/1").should route_to("monthly_summaries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/monthly_summaries/1").should route_to("monthly_summaries#destroy", :id => "1")
    end

  end
end
