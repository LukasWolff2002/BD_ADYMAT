class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.date :start_date                 # fecha inicio
      t.date :end_date                   # fecha fin
      t.string :payment_method          # medio de pago (por ejemplo: "efectivo", "transferencia", etc.)
      t.string :payment_status          # estado del medio de pago (por ejemplo: "pendiente", "pagado")
      t.text :observations              # observaciones adicionales
      t.decimal :discount, precision: 10, scale: 2   # descuento monetario
      t.decimal :freight, precision: 10, scale: 2    # flete (coste adicional por transporte, etc.)
      t.decimal :total_amount, precision: 15, scale: 2 # valor total

      t.timestamps
    end
  end
end
