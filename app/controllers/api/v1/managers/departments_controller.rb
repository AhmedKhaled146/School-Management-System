module Api
  module V1
    module Managers
      class DepartmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department, only: [ :update ]

        # He Can Read Departments Information.
        # He Can Update Departments Information.

        def index
          @departments = Department.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            departments: @departments,
            message: "All Departments Fetched Successfully",
            meta: pagination_meta(@departments)
          }, status: :ok
        end

        def show
          render json: {
            department: @department,
            message: "Department Info. Fetched Successfully"
          }, status: :ok
        end

        def update
          if current_user.id == @department.manager_id
            if @department.update(department_params)
              render json: {
                department: @department,
                message: "Department Info. Updated Successfully"
              }, status: :ok
            else
              render_errors(@department)
            end
          else
            user_not_authorized
          end
        end

        private

        def set_department
          @department = Department.find(params[:id])
        end

        def department_params
          params.require(:department).permit(:name, :description)
        end
      end
    end
  end
end
