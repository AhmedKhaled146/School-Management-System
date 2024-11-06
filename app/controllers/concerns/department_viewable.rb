module DepartmentViewable
  extend ActiveSupport::Concern

  included do
    before_action :set_department, only: [ :show ]
  end

  def index
    authorize @department
    @departments = Department.order(:name).page(params[:page]).per(params[:per_page].presence || 10)
    render json: {
      departments: @departments,
      message: "All Departments fetched successfully",
      meta: pagination_meta(@departments)
    }, status: :ok
  end

  def show
    authorize @department
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