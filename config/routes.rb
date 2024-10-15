Rails.application.routes.draw do
  # get "instructors/index"
  # get "instructors/show"
  # get "instructors/update"
  # get "instructors/destroy"
  # get "students/index"
  # get "students/show"
  # get "students/update"
  # get "students/destroy"

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
   controllers: {
     sessions: 'users/sessions',
     registrations: 'users/registrations'
   }

  resource :students
  resource :instructors

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
