module Api
  module V1
    module Students
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_assignment, only: [ :show ]

        # He Can see All Assignments in Courses Which He Enrolled.
        # He Can See Course With All assignments.
        # He Can See Assignment Details.

        def index
          @assignments = Assignment
                           .joins(course: :enrollments)
                           .where(enrollments: { user_id: current_user.id })
                           .page(params[:page])
                           .per(params[:per_page] || 10)

          render json: {
            assignments: @assignments,
            message: "All assignments in #{@department.name} department fetched successfully",
            meta: pagination_meta(@assignments)
          }, status: :ok
        end

        def courses_assignments
          courses_with_assignments = current_user.enrolled_courses.includes(:assignments).map do |course|
            {
              course_name: course.name,
              assignments: course.assignments.map do |assignment|
                { id: assignment.id, title: assignment.title, description: assignment.description }
              end
            }
          end

          render json: {
            courses_with_assignments: courses_with_assignments,
            message: "All enrolled courses with assignments fetched successfully"
          }, status: :ok
        end

        def show
          render json: {
            assignment: @assignment,
            message: "Assignment #{@assignment.title} found"
          }, status: :ok
        end

        private

        def set_department
          @department = current_user.department
          record_not_found('Department') unless @department
        end

        def set_assignment
          @assignment = Assignment
                          .joins(course: :enrollments)
                          .where(enrollments: { user_id: current_user.id }, id: params[:id])
                          .first
          record_not_found('Assignment') unless @assignment
        end
      end
    end
  end
end