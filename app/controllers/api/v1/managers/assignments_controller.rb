module Api
  module V1
    module Managers
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager
        before_action :set_course
        before_action :set_assignment, only: [ :show ]

        # Manager can view all assignments in a specific course within their department.
        # Manager can view details of a specific assignment in a course.

        def index
          authorize Assignment
          @assignments = policy_scope(@course.assignments).page(params[:page]).per(params[:per_page] || 10)

          render json: {
            assignments: @assignments,
            message: "All Assignments in #{@course.name} course of #{@department.name} department fetched successfully",
            meta: pagination_meta(@assignments)
          }, status: :ok
        end

        def show
          authorize @assignment
          render json: {
            assignment: @assignment,
            message: "Assignment details fetched successfully"
          }, status: :ok # Ensures the manager has permission to view assignments.
        end

        private

        def set_department
          @department = Department.find(params[:department_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end

        def set_manager
          unless @department.manager_id == current_user.id || current_user.admin?
            user_not_authorized
          end
        end

        def set_course
          @course = @department.courses.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end

        def set_assignment
          @assignment = @course.assignments.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Assignment')
        end
      end
    end
  end
end
