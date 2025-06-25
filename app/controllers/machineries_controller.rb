class MachineriesController < ApplicationController
  before_action :set_machinery, only: [:show, :destroy]

  def index
    @machineries = Machinery.order(created_at: :desc)
  end

  def new
    @machinery = Machinery.new
  end

  def create
    @machinery = Machinery.new(machinery_params)
    if @machinery.save
      redirect_to @machinery, notice: 'Maquinaria creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @machinery.destroy
    redirect_to machineries_path, notice: 'Maquinaria eliminada exitosamente.'
  end

  private

  def set_machinery
    @machinery = Machinery.find(params[:id])
  end

  def machinery_params
  params.require(:machinery).permit(
    :nombre, :formato, :horas_por_mantencion,
    :horas_totales, :horas_disponibles,
    :valor_dia, :valor_semana, :valor_mes
  )
end

end
