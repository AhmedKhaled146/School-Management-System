module Api
  module V1
    module Instructors
      class AssignmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_assignment, only: [ :show, :update, :destroy ]
        before_action :assignments_params, only: [ :create, :update ]

        def index
        end

        def show
        end

        def create
        end

        def update
        end

        def destroy
        end

        private

        def assignments_params
        end

        def set_assignment
          @assignment = Assignment.find(params[:id])
        end
      end
    end
  end
end