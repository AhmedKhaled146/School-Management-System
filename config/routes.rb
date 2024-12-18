Rails.application.routes.draw do

    # Devise routes for Users (customized paths)
  devise_for :users, path: 'api/v1', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations'
  }

  namespace :api do
    namespace :v1 do

      # Routes For Users Profiles
      namespace :users do
        resource :profiles, only: [ :show, :update ]
      end

      # Routes For Students
      namespace :students do
        resources :departments, only: [ :index, :show ] do
          resources :courses, only: [ :index, :show ] do
            collection do
              get :enrolled_courses
            end
            resources :assignments, only: [ :index, :show ]
          end
          get "courses-assignments", to: 'assignments#courses_assignments'
        end

        resources :enrollments, only: [ :index, :create, :destroy ]
      end

      # Routes For Instructors
      namespace :instructors do
        resources :departments, only: [ :index, :show ] do
          resources :courses, only: [ :index, :show, :update ] do
            resources :assignments, only: [ :index, :show, :create, :update, :destroy ]
            collection do
              get :courses_instructor_teach
            end
          end
        end

        resources :enrollments, only: [ :index ] do
          member do
            patch :put_final_grade
          end
        end
      end

      # Routes For Managers
      namespace :managers do
        resources :departments, only: [ :index, :show, :update ] do
            resources :courses do
              resources :assignments, only: [ :index, :show ]
            end

            resources :enrollments, only: [ :index ]
            resources :instructors, only: [ :index, :destroy ]
            resources :students, only: [ :index, :destroy ]
        end
      end

      # Routes For Admins
      namespace :admins do
        resources :departments, only: [ :index, :show, :create, :update, :destroy ]
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
