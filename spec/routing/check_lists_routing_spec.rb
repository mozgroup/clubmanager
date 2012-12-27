require "spec_helper"

describe CheckListsController do
  describe "routing" do

    it "routes to #index" do
      get("/check_lists").should route_to("check_lists#index")
    end

    it "routes to #new" do
      get("/check_lists/new").should route_to("check_lists#new")
    end

    it "routes to #show" do
      get("/check_lists/1").should route_to("check_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/check_lists/1/edit").should route_to("check_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/check_lists").should route_to("check_lists#create")
    end

    it "routes to #update" do
      put("/check_lists/1").should route_to("check_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/check_lists/1").should route_to("check_lists#destroy", :id => "1")
    end

  end
end
