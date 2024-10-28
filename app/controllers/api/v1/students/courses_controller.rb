module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_course, only: [ :show ]
        before_action :set_student, only: [ :student_department_courses, :student_enrolled_courses ]

        # See Courses in his Department
        # See All Courses he Enrolled
        # See course Details

        def student_department_courses
          if @student.department
            @department_courses = @student.department.courses.page(params[:page]).per(params[:per_page].presence || 10)
            render json: {
              data: @department_courses,
              message: "All Courses in #{@student.department.name} Department Fetched Successfully",
              meta: pagination_meta(@department_courses)
            }, status: :ok
          else
            render json: {
              errors: "Student does not have an assigned department",
            }, status: :not_found
          end
        end

        def student_enrolled_courses
          @enrolled_courses = @student.enrolled_courses.page(params[:page]).per(params[:per_page] || 10)
          render json: {
            data: @enrolled_courses,
            message: "All courses the student is enrolled in fetched successfully",
            meta: pagination_meta(@enrolled_courses)
          }, status: :ok
        end

        # See Course Details
        def show
          render json: {
            data: @course,
            message: 'Course fetched successfully'
          }, status: 200
        end


        private
        def set_course
          @course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end

        def set_student
          @student = current_user
        end
      end
    end
  end
end
