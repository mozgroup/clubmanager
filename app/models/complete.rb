class Complete < ActiveRecord::Base
  attr_accessible :completable_id, :completeable_type

  belongs_to :completable, polymorphic: true
end
