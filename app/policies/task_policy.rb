class TaskPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def show?
    true
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def update_task_status?
    @record.user_id == user.id
  end
end
