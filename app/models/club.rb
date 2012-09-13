class Club < ActiveRecord::Base
  attr_accessible :address, :name

  validates :name, presence: true

  belongs_to :region
end
