Rails.application.routes.draw do
  
  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'users' }

  resources :users do 
    # collection do 
    #   get :fetch_department
    # end
    get "lock", on: :member
    get "unlock", on: :member
  end

  resources :user_divisions, only: %w(new create destroy)


  resources :orders do
    collection do 
      post :import
      get  :import_file
    end
  end

  resources :divisions do
    collection do 
      post :import
      get :import_file
    end
  end

  # get :export_xls, action: :export_xls, controller: 'orders'
  get 'edit_password_reset', to: 'users#edit_password_reset', as: :edit_password_reset
  patch 'password_reset', to: 'users#password_reset', as: :password_reset
end
