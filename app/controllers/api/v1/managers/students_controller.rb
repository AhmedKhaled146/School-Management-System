module Api
  module V1
    module Managers
      class StudentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department

        # He Can See All Students in his Department.
        # He Can Remove Student from his Department.

        def index
          @students = @department.students
          render json: {
            instructors: @students,
            message: "All Students in #{@department.name} Department Fetched Successfully"
          }, status: :ok
        end

        def destroy
          @student = @department.students.find(params[:id])
          if @student.destroy
            render json: {
              message: "Student removed successfully from #{@department.name} department."
            }, status: :ok
          else
            render_errors(@student)
          end
        rescue ActiveRecord::RecordNotFound
          record_not_found('Student')
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