module Api
  module V1
    module Instructors
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_course, only: [ :show, :update ]
        before_action :set_instructor_courses, only: [ :courses_instructor_teach ]

        # Can See All The Courses in his Department.
        # Instructor can see all courses he teaches.
        # Instructor can view course details.
        # Instructor can update the course he teaches.

        def index
          @courses = @department.courses.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            instructor_department_courses: @courses,
            message: "All Courses in #{@department.name} Department Fetched Successfully",
            meta: pagination_meta(@courses)
          }, status: :ok
        end

        def show
          render json: {
            course: @course,
            message: "Course Details Fetched Successfully"
          }, status: :ok
        end

        def update
          if @course.instructor_id == current_user.id
            if @course.update(course_params)
              render json: {
                data: @course,
                message: 'Course successfully updated'
              }, status: :ok
            else
              render_errors(@course)
            end
          else
            user_not_authorized
          end
        end

        def courses_instructor_teach
          render json: {
            courses: @instructor_courses,
            message: "Courses taught by #{current_user.first_name} fetched successfully",
            meta: pagination_meta(@instructor_courses)
          }, status: :ok
        end

        private

        def course_params
          params.require(:course).permit(:name, :description)
        end

        def set_department
          @department = current_user.department
          record_not_found('Department') unless @department
        end

        def set_course
          @course = @department.courses.find_by(id: params[:id])
          record_not_found('Course') unless @course
        end

        def set_instructor_courses
          @instructor_courses = Course.where(instructor_id: current_user.id).page(params[:page]).per(params[:per_page].presence || 10)
        end
      end
    end
  end
end
