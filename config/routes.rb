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

      # Routes For Users Action See & Edit His Profile.
      namespace :users do
        # routes for Students Profile.
        resource :profiles, only: [ :show, :update ]
      end

      # Routes for Students (Departments, courses, assignments, and Enrollment).
      namespace :students do

        # Routes For Departments.
        resources :departments, only: [ :index, :show ]

        # Routes For Courses
        resources :courses, only: [ :index, :show ] do
          collection do
            get :enrolled_courses
          end
        end

        # Routes For Students Enrollment
        resources :enrollments, only: [ :index, :create, :destroy ]

        # Routes for students assignments
        resources :assignments, only: [ :index, :show ] do
          collection do
            get :courses_assignments
          end
        end

      end

      namespace :instructors do
        resources :departments, only: [ :index, :show ]
        # Routes For Courses.
        resources :courses, only: [ :index, :show, :update ] do
          collection do
            get :courses_instructor_teach
          end
          # Routes For assignments inside their courses
          resources :assignments, only: [ :index, :show, :create, :update, :destroy ]
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
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
