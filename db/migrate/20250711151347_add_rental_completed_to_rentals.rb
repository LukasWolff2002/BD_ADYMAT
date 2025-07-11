class AddRentalCompletedToRentals < ActiveRecord::Migration[7.1]
  def change
    add_column :rentals, :rental_completed, :boolean
  end
end
