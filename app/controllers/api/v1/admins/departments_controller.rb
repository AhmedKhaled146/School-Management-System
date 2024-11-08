module Api
  module V1
    module Admins
      class DepartmentsController < ApplicationController
        include DepartmentViewable
        before_action :authenticate_user!
        before_action :set_department, only: [ :show, :update, :destroy ]

        # Admins Can See All Departments. (including into department_viewable)
        # Admins Can See The Department Details. (including into department_viewable)
        # Admins Can Create a Department.
        # Admins Can Update a Department Manager.
        # Admins Can Destroy a Department.

        def create
          authorize Department
          @department = Department.new(department_params)
          if @department.save
            render json: {
              department: @department,
              message: "#{@department.name} created successfully with #{@department.manager}as a Manager"
            }, status: :created
          end
        end

        def update
          authorize @department
          if @department.update(department_params)
            render json: {
              department: @department,
              message: "Department Info. Updated Successfully"
            }, status: :ok
          else
            render_errors(@department)
          end
        end

        def destroy
          authorize @department
          if @department.destroy
            render json: {
              message: "Department successfully deleted"
            }, status: :ok
          else
            render_errors(@department)
          end
        end

        private

        def department_params
          params.require(:department).permit(:name, :description, :manager_id)
        end
      end
    end
  end
end