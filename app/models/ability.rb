class Ability
  include CanCan::Ability

  def initialize(user)
    user.user_roles.each do |user_role|
      __send__("role_#{user_role.role}")
    end
  end

private

  def role_administrator
    can :manage, Group
    can :manage, GroupReporter
    can :manage, Plugin
    can :manage, Reporter
    can :manage, Service
    can :manage, User
  end
end
