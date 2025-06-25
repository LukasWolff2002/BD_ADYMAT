class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :nombre
      t.string :rut, null: false
      t.timestamps
    end
  end
end