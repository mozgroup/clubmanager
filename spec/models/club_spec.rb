require 'spec_helper'

describe Club do
  it { should validate_presence_of(:name) }
  it { should belong_to(:region) }
  it { should_not allow_mass_assignment_of(:region_id) }
end
