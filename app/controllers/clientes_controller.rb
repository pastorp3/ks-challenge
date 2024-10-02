class ClientesController < ApplicationController
  def index
    @clientes = Cliente.all
  end

  def new
    @cliente = Cliente.new
  end

  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      redirect_to root_path, notice: "Cliente creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def cliente_params
    params.require(:cliente).permit(:first_name, :last_name_paternal, :last_name_maternal, :email, :age, :gender, :curp, :date_of_birth)
  end
end
