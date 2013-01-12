require 'spec_helper'

describe "Checklists" do

  subject { page }

  describe "GET /checklists" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit checklists_path
    end

    it "should render the page" do
      page.should have_content('Checklists')
    end

  end
end
