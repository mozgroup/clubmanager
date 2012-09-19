require 'spec_helper'

describe 'MessagePages' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    2.times do
      message = FactoryGirl.create(:message, send_to: user.full_name)
      message.deliver
    end
    sign_in user
    visit inbox_path
  end

  it { should have_selector('title', text: "Club Manager | Messages") }
  it { should have_selector('h1', text: 'Messages') }
  it { should have_selector('h2', text: 'Club Manager | Messages') }
  it { should have_content('Drafts') }
  it { should have_content('Sent') }
  it { should have_content('Trash') }
  it { should have_selector('div#message-panel') }
  it { should have_link('new-message-link', href: new_message_path) }

  it "should show all inbox messages" do
    user.envelopes.inbox.each do |envelope|
      page.should have_content(envelope.sender_full_name)
      page.should have_content(envelope.message_subject)
    end
  end

#  it "should show a new message" do
#    click_link('new-message-link')
#    page.should have_selector('message-main')
#  end

# describe "new message" do
#   before do
#     click_link('new-message-link')
#   end

#   it { should have_selector('div#message-panel') }
#   it { should have_selector('message-main') }
#   it { should have_selector('send-message') }
# end
end
