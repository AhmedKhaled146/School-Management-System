class AssignmentPolicy < ApplicationPolicy
  def index?
    student? || instructor? || user_is_manager? || admin?
  end

  def show?
    student? || instructor? || user_is_manager? || admin?
  end

  def create?
    instructor? || admin?
  end

  def update?
    instructor? || admin?
  end

  def destroy?
    instructor? || admin?
  end

  def courses_assignments?
    student? || admin? || user_is_manager?
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin? || user_is_manager?
        scope.all
      elsif instructor?
        scope.joins(:course).where(courses: { instructor_id: user.id })
      elsif student?
        scope.joins(course: :enrollments).where(enrollments: { user_id: user.id })
      else
        scope.none
      end
    end
  end
end
