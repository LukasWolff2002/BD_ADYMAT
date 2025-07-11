class CreateRentalSegments < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_segments do |t|
      t.references :rental, null: false, foreign_key: true
      t.references :machinery, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :rate
      t.decimal :discount
      t.decimal :freight
      t.decimal :total_amount

      t.timestamps
    end
  end
end
