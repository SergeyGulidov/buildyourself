class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create

    if user
      
      can :manage, :all if user.role == 1

      if user.role == 2
        can :edit,   User,     :id => user.id
        can :update, User,     :id => user.id
        can :create, Contact
        can :update, Place,    :user_id => user.id
        can :edit,   Place,    :user_id => user.id
        can :create, Request
        can :read, Place
        can :read, Post
        can :create,  Post
        can :edit, Post,       :user_id => user.id
        can :update, Post,     :user_id => user.id
        can :destroy, Post,    :user_id => user.id
        can :create, Feed
        can :destroy, Feed,    :user_id => user.id
        can :create, Schedule
        can :edit, Schedule,   :user_id => user.id
        can :destroy, Schedule,:user_id => user.id
      end

      if user.role == 3
        can :edit,       User
        can :update,     User
        can :create,     Contact
        can :read,       Place
        can :translate,  Place
        can :make_translate, Place
        can :update,     Place
        can :show,       User
        can :index,      User
        can :create,     Request
        can :read,       Post
        can :create,     Post
      end

    end
      can :create, Contact
      can :show,   User
      can :create, Request
      can :read, Place
      can :read, Post
      can :subscribe, Request
      can :subscribed, Request
      can :waitingforactivation, Request
  end
end

