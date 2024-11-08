class DepartmentPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index?
    user.student? || user.instructor? || user.admin?
  end

  def show?
    user.student? || user.instructor? || user.admin?
  end

  def create?
    user.admin?
  end

  def update?
    (user.instructor? && user.user_is_manager?) || user.admin?
  end

  def destroy?
    user.admin?
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
