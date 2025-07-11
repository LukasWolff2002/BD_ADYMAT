class RentalsController < ApplicationController

  RATE_MAP = { "Día" => :valor_dia, "Semana" => :valor_semana, "Mes" => :valor_mes }.freeze

  before_action :set_rental, only: [:show, :edit, :update, :destroy, :finish, :mark_as_paid, :mark_as_unpaid, :change_machinery, :update_machinery]


  def index
    @rentals = Rental.includes(:machinery).all
  end

  def show
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)

    if @rental.save
      machinery = Machinery.find(@rental.machinery_id)
      rate_type = params[:rental][:rate]
      rate_value = machinery.send(RATE_MAP[rate_type])

      @rental.rental_segments.create!(
        machinery: machinery,
        start_date: @rental.start_date,
        end_date: @rental.end_date,
        rate: rate_type,
        discount: @rental.discount.to_f,
        freight: @rental.freight.to_f,
        total_amount: calculate_segment_total_object(
          rate_type,
          rate_value,
          @rental.start_date,
          @rental.end_date,
          @rental.discount.to_f,
          @rental.freight.to_f
        )
      )

      redirect_to @rental, notice: "Arriendo creado con éxito."
    else
      render :new
    end
  end



  def edit
  end

  def update
    if @rental.update(rental_params)
      redirect_to @rental, notice: "El arriendo ha sido actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @rental.destroy
    redirect_to rentals_url, notice: "El arriendo ha sido borrado."
  end

  def finish
    @rental = Rental.find(params[:id])
    if @rental.update(observations: params[:rental][:observations], rental_completed: True)
      redirect_to @rental, notice: "El arriendo fue terminado con éxito."
    else
      render :show, alert: "No se pudo terminar el arriendo."
    end
  end

  def mark_as_paid
    @rental = Rental.find(params[:id])
    if @rental.update(payment_status: "Pagado")
      redirect_to @rental, notice: "El arriendo fue marcado como pagado."
    else
      redirect_to @rental, alert: "No se pudo actualizar el estado de pago."
    end
  end

  def mark_as_unpaid
    @rental = Rental.find(params[:id])
    if @rental.update(payment_status: "Pendiente")
      redirect_to @rental, notice: "El arriendo fue marcado como no pagado."
    else
      redirect_to @rental, alert: "No se pudo actualizar el estado de pago."
    end
  end

  def change_machinery
    @rental = Rental.find(params[:id])
  end

  def update_machinery
    @rental = Rental.find(params[:id])
    old_segment = @rental.rental_segments.order(:start_date).last
    Rails.logger.debug params.inspect

    fecha_cambio = Date.parse(params[:rental][:start_date]) 
    rate_type = params[:rental][:rate]
    new_machinery = Machinery.find(params[:rental][:machinery_id])
    rate_value = new_machinery.send(RATE_MAP[rate_type])
    fecha_final_original = old_segment.end_date

    # Cierra el segmento actual
    old_segment.update!(
      end_date: fecha_cambio - 1.day,
      total_amount: calculate_segment_total(old_segment)
    )

    # Crea el nuevo segmento
    @rental.rental_segments.create!(
      machinery: new_machinery,
      start_date: fecha_cambio,
      end_date: fecha_final_original,
      rate: rate_type,
      discount: params[:discount].to_f,
      freight: params[:freight].to_f,
      total_amount: calculate_segment_total_object(
        rate_type, rate_value, fecha_cambio, fecha_final_original,
        params[:discount].to_f, params[:freight].to_f
      )
    )

    redirect_to @rental, notice: "Maquinaria cambiada exitosamente."
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:machinery_id, :start_date, :end_date, :payment_method,
                                   :payment_status, :observations, :discount, :freight, :total_amount)
  end

  def calculate_segment_total(segment)
    rate_value = segment.machinery.send(RATE_MAP[segment.rate])
    calculate_segment_total_object(segment.rate, rate_value, segment.start_date, segment.end_date, segment.discount, segment.freight)
  end


  def calculate_segment_total_object(rate, rate_value, start_date, end_date, discount, freight)
    days = (end_date - start_date).to_i + 1
    units =
      case rate
      when "Día" then days
      when "Semana" then (days.to_f / 7).ceil
      when "Mes" then (days.to_f / 30).ceil
      else 0
      end

    subtotal = units * rate_value
    subtotal - (subtotal * discount / 100.0) + freight
  end
end
