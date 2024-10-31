module Api
  module V1
    module Managers
      class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :set_manager
        before_action :set_department

        # He Can See All Students in his Department.
        # He Can See All Instructors in his Department.
        # He Can Remove Instructor from his Department.
        # He Can Remove Student from his Department.

        def instructors_list
          @instructors = @department.instructors
          render json: {
            instructors: @instructors,
            message: "All Instructors in #{@department.name} Department Fetched Successfully"
          }, status: :ok
        end

        def students_list
          @students = @department.students
          render json: {
            students: @students,
            message: "All Students in #{@department.name} Department Fetched Successfully"
          }, status: :ok
        end

        def destroy
        end

        private

        def set_department
          @department = Department.find(params[:department_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end
        def set_manager
          unless @department.manager_id == current_user.id
            user_not_authorized
          end
        end
      end
    end
  end
end
