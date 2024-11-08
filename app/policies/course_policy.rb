class CoursePolicy < ApplicationPolicy
  # student - instructor - manager - admin
  def index?
    user.student? || user.instructor? || user.user_is_manager? || user.admin?
  end

  # student - instructor - manager - admin
  def show?
    user.student? || user.instructor? || user.user_is_manager? || user.admin?
  end

  # manager - admin
  def create?
    user_is_manager_of_department? || user.admin?
  end

  # instructor of this course - manager - admin
  def update?
    (user.instructor? && user_is_instructor_of_course?) || user_is_manager_of_department? || user.admin?
  end

  # Manager - admin
  def destroy?
    user_is_manager_of_department? || user.admin?
  end

  def enrolled_courses?
    user.student? || user.admin?
  end

  def courses_instructor_teach?
    user.instructor? && user_is_instructor_of_course? || user.admin?
  end

  private

  # Check if the user is part of the department the course belongs to
  def user_is_in_department?
    record.department_id == user.department_id
  end

  # Check if the user is the manager of the department the course belongs to
  def user_is_manager_of_department?
    user.user_is_manager? && record.department.manager_id == user.id
  end

  # Check if the user is the instructor of the course
  def user_is_instructor_of_course?
    record.instructor_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
  end
end
