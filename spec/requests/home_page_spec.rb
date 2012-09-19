require 'spec_helper'

describe 'HomePage' do

  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      5.times do
        message = FactoryGirl.create(:message, send_to: user.full_name)
        message.deliver
      end
      sign_in user
      visit root_path
    end

    it { should have_selector('h1', text: 'Club Manager') }
    it { should have_selector('div#profile span.name', text: user.full_name) }
    it { should have_selector('header', text: user.title) }
    it { should have_selector('li.current a.shortcut-dashboard') }
    it { should_not have_selector('li.current a.shortcut-messages') }
    it { should have_link('Dashboard', href: './') }
    it { should have_link('Messages', href: '/inbox') }

    it { should have_selector('section#menu') }
    it { should have_selector('span.count', text: user.envelopes.unread_count.to_s) }
  end
end
