class MachineriesController < ApplicationController
  before_action :set_machinery, only: [:show, :destroy]

  def index
    @machineries = Machinery.order(created_at: :desc)
  end

  def show_by_qr
    @machinery = Machinery.find_by!(qr_token: params[:qr_token])
    render :show  # reutiliza la vista show
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

  def download_qr
    machinery = Machinery.find(params[:id])
    qr = RQRCode::QRCode.new(machinery_qr_url(machinery.qr_token))

    png = qr.as_png(size: 300)

    send_data png.to_s,
              type: 'image/png',
              disposition: 'attachment',
              filename: "QR_#{machinery.nombre.parameterize}.png"
  end

  def buscar_por_qr
    machinery = Machinery.find_by(qr_token: params[:qr_token])
    if machinery
      render json: { id: machinery.id, nombre: machinery.nombre }
    else
      render json: {}, status: :not_found
    end
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
