Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'registrations'
}
  resources :company_profiles, only: [:edit, :update]
  resources :employee_profiles, only: [:edit, :update]

  authenticated :user, ->(u) { u.company? } do
    root to: 'company_dashboard#index', as: :company_root
  end

  authenticated :user, ->(u) { u.employee? } do
    root to: 'employee_dashboard#index', as: :employee_root
  end

  root to: 'home#index'
end
