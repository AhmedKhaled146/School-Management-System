class StudentsController < ApplicationController
  before_action :set_student, only: [:show]

  def index
    @students = Student.all
    render json: @students
  end

  def show
    render json: @student, status: :ok
  end

  def update
  end

  def destroy
  end

  private

  def set_student
    @student = current_user.student
  end

  def student_params
    params.require(:student).permit(:fname, :lname, :email, :age, :phone)
  end
end
