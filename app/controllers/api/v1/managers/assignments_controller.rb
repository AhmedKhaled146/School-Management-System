module Api
  module V1
    module Managers
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager

        # He Can See All Assignments in his Department.

        def index
          @assignments = @department.assignments.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            assignments: @assignments,
            message: "All Assignments in #{@department.name} Department Fetched Successfully",
            meta: pagination_meta(@assignments)
          }, status: :ok
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
