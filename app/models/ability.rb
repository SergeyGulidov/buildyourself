class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create


    user ||= User.new(role: 3)



    can :manage, :all if user.role == 1


    if user.role == 2
      can :read, Place
      can :create, Place
      can :create, Contact
      can :update, Place, :user_id => user.id
      can :vote, Place
    end

    if user.role == 3
      can :read, Place
      can :create, Place
      can :create, Contact
    end

  end
end

