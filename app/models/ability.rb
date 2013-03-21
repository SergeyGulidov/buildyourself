class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create
    #alias_action :edit, :update, :to => :update

    user ||= User.new # guest user

    if user.role? :administrator
      can :manage, :all
    # elsif user.role? :operator
    #   can :manage, Post
    else 

      #place controller
      can :read, Place
      can :create, Place
      can :update, Place, :user_id => user.id

      #contact controller
      can :create, Contact


      #photo controller

      can :create, Photo
      can :read, Photo
      can :edit, Photo
      can :destroy, Photo

      # type controller

    end
  end
end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
