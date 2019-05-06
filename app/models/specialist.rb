class Specialist < ApplicationRecord
  belongs_to :specialty
  has_many :reviews
  belongs_to :user
end
