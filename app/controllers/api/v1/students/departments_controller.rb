module Api
  module V1
    module Students
      class DepartmentsController < ApplicationController
        include DepartmentViewable
        before_action :authenticate_user!

        # He Can See All Departments
        # Department Details (any Department)
        # All of this Methods inside app/controllers/concerns/department_viewable.rb file.

      end
    end
  end
end
