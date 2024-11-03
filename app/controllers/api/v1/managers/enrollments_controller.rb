module Api
  module V1
    module Managers
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager

        # He Can See All Enrollment Details in his Department.

        def index
          courses_with_enrollments = @department.courses.includes(:enrollments, :students).map do |course|
            paginated_enrollments = course.enrollments.page(params[:page]).per(params[:per_page] || 10)
            {
              course_name: course.name,
              students: paginated_enrollments.map do |enrollment|
                {
                  student_name: enrollment.student.name,
                  enrollment_date: enrollment.created_at.strftime("%Y-%m-%d"),
                  grade: enrollment.grade
                }
              end,
              meta: pagination_meta(paginated_enrollments)
            }
          end

          render json: {
            department: @department.name,
            courses_with_enrollments: courses_with_enrollments,
            message: "All enrollments in #{@department.name} Department fetched successfully"
          }, status: :ok
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
      end
    end
  end
end
