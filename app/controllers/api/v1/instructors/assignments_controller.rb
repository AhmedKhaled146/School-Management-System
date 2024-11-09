module Api
  module V1
    module Instructors
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_course
        before_action :authorize_instructor!
        before_action :set_assignment, only: [ :show, :update, :destroy ]

        # He Can See all assignments in Courses.
        # He Can See assignments Details.
        # He Can Create an assignments.
        # He Can Update an Assignments.
        # He Can Destroy anmAssignments.

        def index
          authorize Assignment
          @assignments = policy_scope(@course.assignments).page(params[:page]).per(params[:per_page] || 10)

          render json: {
            assignments: @assignments,
            message: "All Assignments in #{@course.name} Course Fetched Successfully",
            meta: pagination_meta(@assignments)
          }, status: :ok
        end

        def show
          authorize @assignment
          render json: {
            assignment: @assignment,
            message: "Assignment Fetched Successfully"
          }, status: :ok
        end

        def create
          @assignment = @course.assignments.build(assignments_params)
          authorize @assignment

          if @assignment.save
            render json: {
              assignment: @assignment,
              message: "Assignment created Successfully"
            }, status: :created
          else
            render_errors(@assignment)
          end
        end

        def update
          authorize @assignment
          if @assignment.update(assignments_params)
            render json: {
              assignment: @assignment,
              message: "Assignment updated successfully"
            }, status: :ok
          else
            render_errors(@assignment)
          end
        end

        def destroy
          authorize @assignment
          if @assignment.destroy
            render json: {
              message: "Assignment deleted successfully"
            }, status: :ok
          else
            render_errors(@assignment)
          end
        end

        private

        def set_department
          @department = current_user.department
          record_not_found('Department') unless @department
        end

        def set_course
          @course = @department.courses.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Course')
        end


        def set_assignment
          @assignment = @course.assignments.find_by(id: params[:id])
          record_not_found('Assignment') unless @assignment
        end

        def assignments_params
          params.require(:assignment).permit(:title, :description)
        end

        def authorize_instructor!
          unless current_user.id == @course.instructor_id
            user_not_authorized
          end
        end
      end
    end
  end
end
