class DepartmentPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    student? || instructor? || admin?
  end

  def show?
    student? || instructor? || admin?
  end

  def update?
    instructor? && user_is_manager? || admin?
  end

  private

  def student?
    user.role == 'student'
  end

  def instructor?
    user.role == 'instructor'
  end

  def admin?
    user.role == 'admin'
  end

  def user_is_manager?
    record.manager_id == user.id  # Ensure user is the department's manager
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
