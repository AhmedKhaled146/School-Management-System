module Api
  module V1
    module Managers
      class DepartmentsController < ApplicationController
        include DepartmentViewable
        before_action :authenticate_user!
        before_action :set_department, only: [ :update ]

        # He Can Read Departments Information.
        # He Can Update Departments Information.

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
