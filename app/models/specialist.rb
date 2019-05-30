class Specialist < ApplicationRecord
  belongs_to :specialty
  has_many :reviews
  belongs_to :user

  def rating
    sumOfRating = 0
    self.reviews.each do |review|
      sumOfRating = sumOfRating + review.rating
    end
    rating = sumOfRating.to_f / self.reviews.count
  end

  def address
    address = self.city + ", " + self.street
  end

  def full_name
    full_name = self.first_name + " " + self.last_name
  end
end
