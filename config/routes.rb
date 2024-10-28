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
      # Routes for Students (Departments, courses, assignments, and profile)
      namespace :students do
        resources :departments, only: [ :index, :show ]
        resources :courses, only: [ :show ]
        get "student-department-courses", to: "courses#student_department_courses"
        get "student-enrolled-courses", to: "courses#student_enrolled_courses"
        resources :assignments, only: [ :index, :show ]
        resources :profiles, only: [ :show, :update ]
        resources :enrollments, only: [ :create, :destroy ]
      end

      namespace :instructors do
        get "instructor-department-courses", to: "courses#instructor_department_courses"
        get "courses-instructor-teach", to: "courses#courses_instructor_teach"
        resources :courses, only: [ :update ]
        resources :assignments
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
