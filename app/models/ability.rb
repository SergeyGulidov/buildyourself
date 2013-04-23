class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create

    if user
      
      can :manage, :all if user.role == 1

      if user.role == 2
        can :edit,   User,    :id => user.id
        can :update, User,    :id => user.id
        can :create, Contact
        can :create, Place
        can :show,   Place,   :user_id => user.id
        can :update, Place,   :user_id => user.id
        can :edit,   Place,   :user_id => user.id
        can :vote,   Place
        can :index, Brain

      end

      if user.role == 3
        can :edit,   User
        can :update, User
        can :create, Contact
        can :create, Place
        can :read,   Place
        can :translate, Place
        can :make_translate, Place
        can :update, Place
        can :vote,   Place
        can :index, Brain
        can :show, User
        can :index, User
      end

    end
      #can :read, Place
      can :create, Contact
      can :index, Brain
      can :show, User
  end
end

