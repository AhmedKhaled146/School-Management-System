module Api
  module V1
    module Instructors
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_enrollment, only: [ :put_final_grade ]

        # He Can See All Students who Enrolled the Course which he teaches.
        # He Can Put The final Grade for the Course.

        def index
          # Find all courses taught by the current instructor
          instructor_courses = Course.where(instructor_id: current_user.id)
          # Prepare the response structure
          response = instructor_courses.map do |course|
            # For each course, find the students enrolled
            students = course.enrollments.includes(:user).map do |enrollment|
              student = enrollment.user
              {
                id: student.id,
                first_name: student.first_name,
                last_name: student.last_name,
                email: student.email,
                phone: student.phone
              }
            end
            # Format each course with its students
            {
              course_name: course.name,
              students: students
            }
          end

          render json: response, status: :ok
        end



        def put_final_grade
          # Ensure only the course instructor can set the grade
          if current_user.id == @enrollment.course.instructor_id
            @enrollment.update(grade: params[:grade])
            render json: { message: "Grade updated successfully" }, status: :ok
          else
            user_not_authorized
          end
        end

        private

        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
        end
      end
    end
  end
end