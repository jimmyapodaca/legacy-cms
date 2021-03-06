class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
        user ||= User.new # guest user (not logged in)
          if user.super_admin
            can :manage, :all
          else
            can [:read, :update, :destroy], Site, id: user.site_ids
            can :manage, Page, id: user.page_ids                  
            can :manage, Page, site: {id: user.site_ids}
            can :manage, Category, id: user.category_ids
            can :manage, Category, site: {id: user.site_ids}
            can :manage, Post, category: {id: user.category_ids}
            can :manage, Post, category: {site_id: user.site_ids}
            can :manage, HomePage, site: {id: user.site_ids}
            can :manage, Stylesheet, site: {id: user.site_ids}
            can :manage, PageElement, site: {id: user.site_ids}
            can :manage, Menu, site: {id: user.site_ids}
            can :manage, QuickLink, site: {id: user.site_ids}
            # Performed checks for actions:
            can [:read, :create, :destroy], Ckeditor::Picture
            can [:read, :create, :destroy], Ckeditor::AttachmentFile
            can :access, :ckeditor   # needed to access Ckeditor filebrowser
            can :read, :all
        end
    #
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
  end
end
