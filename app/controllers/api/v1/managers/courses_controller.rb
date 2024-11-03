module Api
  module V1
    module Managers
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager
        before_action :set_course, only: [ :show, :update, :destroy ]

        # He Can See All Courses in his department.
        # He Can See Course Details just in his department.
        # He Can Create Course in Department which he manage.
        # He Can Update Course in Department which he manage.
        # He can Delete Course in Department which he manage.

        def index
          @courses = @department.courses.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            data: @courses,
            message: "All Courses in #{@department.name} department fetched successfully",
            meta: pagination_meta(@courses)
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

        def update
          if @course.update(course_params)
            render json: {
              data: @course,
              message: "Course updated successfully"
            }, status: :ok
          end
        end

        def destroy
          if @course.destroy
            render json: {
              message: "Course deleted successfully"
            }, status: :ok
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
          params.permit(:name, :description)
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