module Api
  module V1
    module Instructors
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_course, only: [ :create ]
        before_action :set_assignment, only: [ :show, :update, :destroy ]
        before_action :assignments_params, only: [ :create, :update ]

        def index
          # Find all courses taught by the current instructor
          instructor_courses = Course.where(instructor_id: current_user.id)
          response = instructor_courses.map do |course|
            # For each course, find the assignments created by the instructor
            assignments = course.assignments.map do |assignment|
              {
                id: assignment.id,
                title: assignment.title,
                description: assignment.description,
              }
            end
            {
              course_name: course.name,
              assignments: assignments
            }
          end
          render json: response, status: :ok
        end

        def show
          render json: {
            assignment: @assignment,
            message: "Assignment Fetched Successfully"
          }, status: 200
        end

        def create
          if current_user.id == @course.instructor_id
            @assignment = @course.assignments.build(assignments_params)
            if @assignment.save
              render json: {
                assignment: @assignment,
                message: "Assignment created Successfully"
              }, status: :created
            else
              render_errors(@assignment)
            end
          else
            user_not_authorized
          end
        end

        def update
          if current_user.id == @assignment.course.instructor_id
            if @assignment.update(assignments_params)
              render json: {
                assignment: @assignment,
                message: "Assignment updated successfully"
              }, status: :ok
            else
              render_errors(@assignment)
            end
          else
            user_not_authorized
          end
        end

        def destroy
          if current_user.id == @assignment.course.instructor_id
            @assignment.destroy
            render json: { message: "Assignment deleted successfully" }, status: :no_content
          else
            user_not_authorized
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
          @assignment = Assignment.find(params[:id])
        end

        def set_instructor
          @instructor = current_user
        end
      end
    end
  end
end