Rails.application.routes.draw do
  resources :clientes, only: [:index, :new, :create]
  resources :cuentas, only: [:index, :new, :create]

  root "clientes#index"
end
