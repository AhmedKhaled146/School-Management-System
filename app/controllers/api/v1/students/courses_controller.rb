module Api
  module V1
    module Students
      class CoursesController < ApplicationController
        before_action :authenticate_user!
        before_action :authorize_student!, only: [ :enrolled_courses ]
        before_action :set_department
        before_action :set_course, only: [ :show ]

        # See Courses in his Department
        # See All Courses he Enrolled
        # See course Details

        def index
          @courses = @department.courses.page(params[:page]).per(params[:per_page].presence || 10)
          render json: {
            courses: @courses,
            message: "Courses for #{@department.name} department fetched successfully",
            meta: pagination_meta(@courses)
          }, status: :ok
        end

        def show
          authorize @course  # Add authorization check based on the policy
          render json: {
            course: @course,
            message: "Course details fetched successfully"
          }, status: :ok
        end

        def enrolled_courses
          @enrolled_courses = current_user.enrolled_courses.page(params[:page]).per(params[:per_page] || 10)
          render json: {
            data: @enrolled_courses,
            message: "All courses the student is enrolled in fetched successfully",
            meta: pagination_meta(@enrolled_courses)
          }, status: :ok
        end

        private

        def authorize_student!
          unless policy(Course.new).enrolled_courses?
            user_not_authorized
          end
        end

        def set_department
          @department = current_user.department
          record_not_found('Department') unless @department
        end

        def set_course
          @course = @department.courses.find_by(id: params[:id])
          record_not_found('Course') unless @course
        end
      end
    end
  end
end
