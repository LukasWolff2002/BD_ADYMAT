class Rental < ApplicationRecord
  belongs_to :machinery
  has_many :rental_segments, dependent: :destroy
  validate :rental_hours_do_not_exceed_availability
  after_save :sync_total_amount

  private

  def rental_hours_do_not_exceed_availability
    return if start_date.blank? || end_date.blank? || machinery.blank?

    rental_days = (end_date - start_date).to_i + 1
    rental_hours = rental_days * 8

    if rental_hours > machinery.horas_disponibles.to_i
      errors.add(:base, "La reserva excede las horas disponibles de esta maquinaria (#{machinery.horas_disponibles}h). Se requieren #{rental_hours}h.")
    end
  end

  def sync_total_amount
    update_column(:total_amount, rental_segments.sum(&:total_amount))
  end
end
