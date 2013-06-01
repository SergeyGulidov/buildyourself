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
        can :edit, Schedule,     :user_id => user.id
        can :update, Schedule,   :user_id => user.id
        can :destroy, Schedule,  :user_id => user.id
      end

      if user.role == 3
        can :index,      Request
        can :create,     Place
        can :edit,       User,  :id => user.id
        can :update,     User,  :id => user.id
        can :translate,  Place
        can :make_translate, Place
        can :update,     Place
        can :index,      User
        can :unapproved, Post
        can :approve,    Post
        can :create,     Post
        can :edit,       Post
        can :update,     Post
        can :index,      Contact
      end

    end
      can :about,   Contact
      can :destroy, Subscriber
      can :confirm, Subscriber
      can :create, Subscriber
      can :destroy, Subscriber
      can :create, Contact
      can :show,   User
      can :create, Request
      can :read, Place
      can :read, Post
      can :subscribe, Request
      can :subscribed, Request
      can :waitingforactivation, Request
      can :news, Feed
  end
end

