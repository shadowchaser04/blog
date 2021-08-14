Rails.application.routes.draw do

  # ---------------------------------------------------------------------------
  # Admin
  # ---------------------------------------------------------------------------
  namespace :admin do

    # Admin dashboard
    get '', to: 'dashboard#index', as: '/'

    # devise resource with additinal controller and sessions. This is used for
    # permitting username and email.
    devise_for :users, controllers: { sessions: 'admin/users/sessions', registrations: 'admin/users/registrations'}

    # create a Admin resource
    resources :articles

  end

  # root
  root 'pages#welcome'

  # public resources
  resources :articles, only: [:index, :show]

end
