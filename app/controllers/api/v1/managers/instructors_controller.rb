module Api
  module V1
    module Managers
      class InstructorsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department

        # He Can See All Instructors in his Department.
        # He Can Remove Instructor from his Department.

        def index
          @instructors = @department.instructors
          render json: {
            instructors: @instructors,
            message: "All Instructors in #{@department.name} Department Fetched Successfully"
          }, status: :ok
        end

        def destroy
          @instructor = @department.instructors.find(params[:id])
          if @instructor.destroy
            render json: {
              message: "Instructor removed successfully from #{@department.name} department."
            }, status: :ok
          else
            render_errors(@instructor)
          end
        rescue ActiveRecord::RecordNotFound
          record_not_found('Instructor')
        end

        private

        def set_department
          @department = Department.find(params[:department_id])
          unless @department.manager_id == current_user.id
            user_not_authorized
          end
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end
      end
    end
  end
end
