module Api
  module V1
    module Managers
      class DepartmentsController < ApplicationController
        include DepartmentViewable

        before_action :authenticate_user!
        before_action :set_department
        before_action :authorize_manager!, only: [ :update ]

        # He Can See All Departments.
        # He Can Read Departments Information.
        # He Can Update Departments Information.

        def update
          if @department.update(department_params)
            render json: {
              department: @department,
              message: "Department Info. Updated Successfully"
            }, status: :ok
          else
            render_errors(@department)
          end
        end

        private

        def authorize_manager!
          user_not_authorized unless current_user.id == @department.manager_id
        end

        def department_params
          params.require(:department).permit(:name, :description)
        end
      end
    end
  end
end
