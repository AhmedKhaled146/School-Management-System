module Api
  module V1
    module Managers
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager
        before_action :set_course, only: [ :show, :destroy ]

        # He Can See All Courses in his department.
        # He Can See Course Details just in his department.
        # He Can Create Course in his Departments which he manage it.
        # He can Delete Course in his Department.

        def index
          @department_courses = @department.courses.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            data: @department_courses,
            message: "All Courses in #{@department.name} department fetched successfully",
            meta: pagination_meta(@department_courses)
          }, status: :ok
        end

        def show
          render json: {
            data: @course,
            message: "Course Details fetched successfully"
          }, status: :ok
        end

        def create
          @course = @department.courses.build(course_params)
          if @course.save
            render json: {
              data: @course,
              message: "Course created successfully in #{@department.name} department"
            }, status: :created
          else
            render_errors(@course)
          end
        end

        def destroy
          if @course.destroy
            render json: {
              message: "Course deleted successfully"
            }, status: :no_content
          else
            render_errors(@course)
          end
        end

        private

        def set_department
          @department = Department.find(params[:department_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end

        def set_manager
          unless @department.manager_id == current_user.id
            user_not_authorized
          end
        end

        def course_params
          params.permit(:name, :description, :department_id, :instructor_id)
        end

        def set_course
          @course = @department.courses.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end
      end
    end
  end
end