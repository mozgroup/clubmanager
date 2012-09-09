require 'spec_helper'

describe "SessionsPages" do

  describe "authentication" do
    
    subject { page }

    describe "signin page" do
      before { visit signin_path }

      it { should have_selector('#login-title') }
    end

  end

end
