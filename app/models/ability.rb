class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create


    user ||= User.new(role: 3)



    can :manage, :all if user.role == 1


    if user.role == 2
      
      can :create, Contact
      can :create, Place
      can :show,   Place,   :user_id => user.id
      can :update, Place,   :user_id => user.id
      can :edit,   Place,   :user_id => user.id
      can :read,   Place,   :user_id => user.id
      can :vote, Place
      can :index, Brain
    end

    if user.role == 3
      #can :read, Place
      can :create, Place
      can :create, Contact
      can :index, Brain
    end

  end
end

