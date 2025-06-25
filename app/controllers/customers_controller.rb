class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :destroy]

  def index
    @customers = Customer.order(created_at: :desc)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Cliente creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Cliente eliminado exitosamente.'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:nombre, :rut)
  end
end
