# == Schema Information
#
# Table name: completes
#
#  id               :integer          not null, primary key
#  completable_id   :integer
#  completable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Complete < ActiveRecord::Base
  attr_accessible :completable_id, :completeable_type

  belongs_to :completable, polymorphic: true
end
