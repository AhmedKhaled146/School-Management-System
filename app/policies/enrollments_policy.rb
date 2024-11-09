class EnrollmentsPolicy < ApplicationPolicy

  def index?
    student? || instructor? || user_is_manager? || admin?
  end

  def show?
    student? || admin?
  end

  def create?
    student?
  end

  def destroy?
    student? && within_allowed_timeframe? || admin?
  end

  def put_final_grade
    instructor? || admin?
  end

  private

  def within_allowed_timeframe?
    record.created_at > 1.week.ago
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin?
        scope.all
      elsif instructor?
        scope.joins(:course).where(courses: { instructor_id: user.id })
      elsif student?
        scope.where(user_id: user.id)
      elsif user_is_manager?
        scope.joins(course: :department).where(departments: { manager_id: user.id })
      else
        scope.none
      end
    end
  end
end
