class CuentasController < ApplicationController
  before_action :set_clientes, only: [:new, :create]

  def new
    @cuenta = Cuenta.new
  end

  def create
    @cuenta = Cuenta.new(cuenta_params)

    if @cuenta.save
      redirect_to root_path, notice: "Cuenta creada exitosamente."
    else
      flash.now[:alert] = "No se pudo crear la cuenta. Por favor, corrige los errores."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_clientes
    @clientes = Cliente.all
  end

  def cuenta_params
    params.require(:cuenta).permit(:account_number, :cliente_id)
  end
end
