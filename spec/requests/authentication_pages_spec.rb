require 'spec_helper'

describe "AuthenticationPages" do

  describe "Authentication" do
    
    subject { page }

    describe "signin page" do
      before { visit sign_in_path }

      it { should have_selector('h1', text: 'Sign in') }
    end

  end

end
