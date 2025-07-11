class RentalSegment < ApplicationRecord
  belongs_to :rental
  belongs_to :machinery
end
