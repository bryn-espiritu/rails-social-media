class PostPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def update?
    user.present? && record.user_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
