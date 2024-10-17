class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  def index
    @departments = Department.all
    render json: {
      data: @departments,
      status: :ok,
      message: "All Departments fetched successfully"
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
        status: :creates,
        message: "Department successfully created"
      }, status: :created
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  def update
    if @department.update(department_params)
      render json: @department
    end
  end

  def destroy
  end

  private

  def department_params
    params.require(:department).permit(:name, :manager_id, :hire_date)
  end

  def set_department
    @department = Department.find(params[:id])
  end
end
