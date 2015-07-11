class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.super_admin?
    if user.admin?
      can [:read, :create, :delete], [User, Group]
      can :update, User do |u|
        u.customer_id.eql? user.customer_id
      end
      can [:show_read, :update], Group do |g|
        g.customer_id.eql? user.customer_id
      end
      can :manage, Category do |c|
        c.group.customer_id.eql? user.customer_id
      end
      can :manage, Post do |p|
        p.category.group.customer_id.eql? user.customer_id
      end
      can :manage, Document do |d|
        d.category.group.customer_id.eql? user.customer_id
      end
      can :delete, Comment
    end
    if user.group_admin?
      can :update, User do |u|
        u.eql? user
      end
      can :read, Group
      can :show_read, Group do |g|
        g.group_admin.eql? user
      end
      can :manage, Category do |c|
        c.group.group_admin.eql? user
      end
      can :manage, Post do |p|
        p.category.group.group_admin.eql? user
      end
      can :manage, Document do |d|
        d.category.group.group_admin.eql? user
      end
      can :delete, Comment
    end
    return unless user.member?
    can :update, User do |u|
      u.eql? user
    end
    can :read, Group
    can :show_read, Group do |g|
      user.group_member(g)
    end
    can :read, Category do |c|
      user.group_member(c.group)
    end
    can :read, Post do |p|
      user.group_member(p.category.group)
    end
    can :read, Document do |d|
      user.group_member(d.category.group)
    end
    can :delete, Comment do |c|
      c.user.eql? user
    end
  end
end
