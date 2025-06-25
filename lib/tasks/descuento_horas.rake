namespace :maquinarias do
  desc "Descuenta 8 horas por día de uso activo"
  task descontar_horas: :environment do
    Rental.where("start_date <= ? AND end_date >= ?", Date.today, Date.today).find_each do |rental|
      machinery = rental.machinery
      next if machinery.horas_disponibles.nil? || machinery.horas_disponibles <= 0

      maquinaria_nueva = [machinery.horas_disponibles - 8, 0].max
      machinery.update(horas_disponibles: maquinaria_nueva)
    end
    puts "Horas descontadas correctamente"
  end
end
