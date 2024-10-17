class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  def index
    @departments = Department.page(params[:page]).per(params[:per_page].presence || 10)
    render json: {
      data: @departments,
      status: :ok,
      message: "All Departments fetched successfully",
      meta: pagination_meta(@departments)
    }
  end

  def show
    render json: {
      data: @department,
      status: :ok,
      message: "Department details successfully fetched"
    }
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      render json: {
        data: @department,
        status: :created,
        message: "Department successfully created"
      }, status: :created
    else
      render_errors(@department)
    end
  end

  def update
    if @department.update(department_params)
      render json: {
        data: @department,
        status: :ok,
        message: "Department successfully updated"
      }
    else
      render_errors(@department)
    end
  end

  def destroy
    if @department.destroy
      render json: {
        data: nil,
        status: :ok,
        message: "Department successfully deleted"
      }
    else
      render_errors(@department)
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :manager_id, :hire_date)
  end

  def set_department
    @department = Department.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found('Department')
  end
end
