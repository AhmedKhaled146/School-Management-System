module Api
  module V1
    module Instructors
      class DepartmentsController < ApplicationController
        include DepartmentViewable
        before_action :authenticate_user!

        # He Can See All Departments. (Same With Students)
        # He Can See Department Details. (Same With Students)
        # All of this Methods inside app/controllers/concerns/department_viewable.rb file.

      end
    end
  end
end