class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]  # <-- agregamos :destroy

  def index
    @offset = params[:offset].to_i || 0
    @users = User.order(created_at: :desc).offset(@offset).limit(10)
    @has_more_data = User.offset(@offset + 10).exists? # ✅ Verifica si hay más usuarios para cargar
  end
  

    def new
      @user = User.new
    end

    def show
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      
      if @user.save
        redirect_to users_path, notice: 'Usuario creado exitosamente.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to users_path, notice: 'Usuario actualizado exitosamente.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
    

    # DELETE /users/:id
    def destroy
      @user.destroy
      redirect_to users_path, notice: "Usuario eliminado exitosamente."
    end

    private

    def user_params
      params.require(:user).permit(:nombre, :apellido, :rut, :password, :cargo, :contrato, :email)
    end


    def set_user
      @user = User.find_by(id: params[:id])
      unless @user
        redirect_to users_path, alert: 'Usuario no encontrado.'
      end
    end
  end