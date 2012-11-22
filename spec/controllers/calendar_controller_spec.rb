require 'spec_helper'

describe CalendarController do

  describe "GET 'index'" do
    before do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:envelope, 5, recipient: @user)
      sign_in @user
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end
  end

end
