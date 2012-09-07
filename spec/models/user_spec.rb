# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  employee_number :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_format_of(:email).with(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i).with_message('Email has an invalid format') } 
  it { should_not allow_mass_assignment_of(:password_digest) }
  it { should validate_presence_of(:employee_number) }
  it { should validate_numericality_of(:employee_number) }

  describe "Full Name method" do
    its(:full_name) { should == "#{@user.first_name} #{@user.last_name}" }
  end
end
