module Api
  module V1
    module Instructors
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_instructor, only: [ :courses_instructor_teach, :instructor_department_courses ]
        before_action :set_course, only: [ :show, :update ]

        # He can See All the courses he teaches.
        # Can See All The Courses in his Department.
        # He Can See Course Details.
        # He Can Update The Course Which he Teaches.

        def courses_instructor_teach
          @courses = Course.where(instructor_id: @instructor.id).page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            data: @courses,
            message: "All Courses taught by #{@instructor.name} fetched successfully",
            meta: pagination_meta(@courses)
          }, status: :ok
        end

        def instructor_department_courses
          @department_courses = @instructor.department.courses.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            instructor_department_courses: @department_courses,
            message: "All Courses in #{@instructor.department.name} Department Fetched Successfully",
            meta: pagination_meta(@department_courses)
          }, status: :ok
        end

        def show
          if @course.department_id == @instructor.department_id
            render json: {
              course: @course,
              message: "Course Details Fetched Successfully"
            }, status: :ok
          else
            user_not_authorized
          end
        end

        def update
          if @course.instructor_id == @instructor.id
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

        private

        def set_course
          @course = Course.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end

        def course_params
          params.require(:course).permit(:name, :description)
        end

        def set_instructor
          @instructor = current_user
        end
      end
    end
  end
end