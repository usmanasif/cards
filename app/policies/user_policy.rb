class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, records)
    @user = user
    @records = records
  end

  def index?
    user.admin?
  end

  def new?
    index?
  end

  def create?
    index?
  end
end