class CreateMachineries < ActiveRecord::Migration[7.1]
  def change
    create_table :machineries do |t|
      t.string :nombre
      t.string :formato
      t.integer :horas_por_mantencion
      t.integer :horas_totales
      t.integer :horas_disponibles
      t.integer :valor_dia
      t.integer :valor_semana
      t.integer :valor_mes
      t.string :qr_token, null: false
      t.timestamps
    end
    add_index :machineries, :qr_token, unique: true
  end
end