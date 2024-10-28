module Api
  module V1
    module Students
      class DepartmentsController < ApplicationController
        before_action :set_department, only: [ :show ]

        # He Can See All Departments
        # Department Details (any Department)

        def index
          @departments = Department.order(:name).page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            departments: @departments,
            message: "All Departments fetched successfully",
            meta: pagination_meta(@departments)
          }, status: :ok
        end

        def show
          render json: {
            department: @department,
            message: "Department Fetched successfully"
          }, status: :ok
        end

        private

        def set_department
          @department = Department.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end

      end
    end
  end
end
