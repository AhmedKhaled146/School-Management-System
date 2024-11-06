module Api
  module V1
    module Students
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_course, only: [ :index, :show ]
        before_action :set_assignment, only: [ :show ]

        # Fetch all assignments for the specific course in the student's department only if the student is enrolled in the course.
        # See Assignment details.
        # See Assignments with Courses etc.
        def index
          @assignments = Assignment
                           .joins(course: :enrollments)
                           .where(enrollments: { user_id: current_user.id }, courses: { id: @course.id })
                           .page(params[:page])
                           .per(params[:per_page] || 10)

          render json: {
            assignments: @assignments,
            message: "All assignments for course '#{@course.name}' fetched successfully",
            meta: pagination_meta(@assignments)
          }, status: :ok
        end

        def show
          render json: {
            assignment: @assignment,
            message: "Assignment '#{@assignment.title}' found"
          }, status: :ok
        end

        def courses_assignments
          paginated_courses = current_user.enrolled_courses
                                          .includes(:assignments)
                                          .page(params[:course_page])
                                          .per(params[:course_per_page] || 5)

          courses_with_assignments = paginated_courses.map do |course|
            paginated_assignments = course.assignments
                                          .page(params[:assignment_page])
                                          .per(params[:assignment_per_page] || 10)

            {
              course_name: course.name,
              assignments: paginated_assignments.map do |assignment|
                { id: assignment.id, title: assignment.title, description: assignment.description }
              end,
              assignments_meta: pagination_meta(paginated_assignments)
            }
          end

          render json: {
            courses_with_assignments: courses_with_assignments,
            courses_meta: pagination_meta(paginated_courses),
            message: "All enrolled courses with assignments fetched successfully"
          }, status: :ok
        end

        private

        def set_department
          @department = current_user.department
          record_not_found('Department') unless @department
        end

        def set_course
          @course = @department.courses
                               .joins(:enrollments)
                               .where(enrollments: { user_id: current_user.id }, id: params[:course_id])
                               .first
          record_not_found('Course') unless @course
        end

        def set_assignment
          @assignment = Assignment
                          .joins(course: :enrollments)
                          .where(enrollments: { user_id: current_user.id }, courses: { id: @course.id }, id: params[:id])
                          .first
          record_not_found('Assignment') unless @assignment
        end
      end
    end
  end
end
