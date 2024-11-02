module Api
  module V1
    module Instructors
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_course
        before_action :authorize_instructor!
        before_action :set_assignment, only: [ :show, :update, :destroy ]

        # He Can See all assignments in Courses.
        # He Can See assignments Details.
        # He Can Create an assignments.
        # He Can Update an Assignments.
        # He Can Destroy anmAssignments.

        def index
          assignments = @course.assignments
          render json: {
            course_name: @course.name,
            assignments: assignments.map { |a| assignment_details(a) }
          }, status: :ok
        end

        def show
          render json: {
            assignment: assignment_details(@assignment),
            message: "Assignment Fetched Successfully"
          }, status: :ok
        end

        def create
          @assignment = @course.assignments.build(assignments_params)
          if @assignment.save
            render json: {
              assignment: assignment_details(@assignment),
              message: "Assignment created Successfully"
            }, status: :created
          else
            render_errors(@assignment)
          end
        end

        def update
          if @assignment.update(assignments_params)
            render json: {
              assignment: assignment_details(@assignment),
              message: "Assignment updated successfully"
            }, status: :ok
          else
            render_errors(@assignment)
          end
        end

        def destroy
          if @assignment.destroy
            render json: {
              message: "Assignment deleted successfully"
            }, status: :no_content
          else
            render_errors(@assignment)
          end
        end

        private

        def assignments_params
          params.require(:assignment).permit(:title, :description)
        end

        def set_course
          @course = Course.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end

        def set_assignment
          @assignment = @course.assignments.find_by(id: params[:id])
          record_not_found('Assignment') unless @assignment
        end

        def authorize_instructor!
          unless current_user.id == @course.instructor_id
            render json: { error: 'Not authorized to manage assignments for this course' }, status: :forbidden
          end
        end

        def assignment_details(assignment)
          {
            id: assignment.id,
            title: assignment.title,
            description: assignment.description
          }
        end
      end
    end
  end
end
