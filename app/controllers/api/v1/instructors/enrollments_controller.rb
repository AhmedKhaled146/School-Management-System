module Api
  module V1
    module Instructors
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_enrollment, only: [ :put_final_grade ]
        before_action :authorize_instructor_for_enrollment, only: [ :put_final_grade ]

        def index
          instructor_courses = courses_taught_by_instructor
          response = format_courses_with_students(instructor_courses)

          render json: response, status: :ok
        end

        def put_final_grade
          if @enrollment.update(grade: grade_params[:grade])
            render json: { message: "Grade updated successfully" }, status: :ok
          else
            render_errors(@enrollment)
          end
        end

        private

        def courses_taught_by_instructor
          Course.where(instructor_id: current_user.id).includes(enrollments: :user)
        end

        def format_courses_with_students(courses)
          courses.map do |course|
            {
              course_name: course.name,
              students: format_students(course.enrollments)
            }
          end
        end

        def format_students(enrollments)
          enrollments.map do |enrollment|
            student = enrollment.user
            {
              id: student.id,
              first_name: student.first_name,
              last_name: student.last_name,
              email: student.email,
              phone: student.phone
            }
          end
        end

        def grade_params
          params.require(:enrollment).permit(:grade)
        end

        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Enrollment not found" }, status: :not_found
        end

        def authorize_instructor_for_enrollment
          unless current_user.id == @enrollment.course.instructor_id
            user_not_authorized
          end
        end
      end
    end
  end
end
