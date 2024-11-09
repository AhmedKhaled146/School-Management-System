# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  protected

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
    record.respond_to?(:manager_id) && record.manager_id == user.id
    # record.respond_to?(:department) && record.department.manager_id == user.id
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
