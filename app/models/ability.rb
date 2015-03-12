class Ability
  include CanCan::Ability

	def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.is? :admin
      can :manage, User
      can :manage, Maintainence
      can :read, MonitorJagent
      can :manage, User, :id => user.id
      can :manage, Resource
      can :manage, Page
      can :manage, Industry
      can :manage, Company
      can :manage, Town
      can :manage, Location
      can :manage, Address
      can :manage, Resource
      can :manage, ResourceType
      can :manage, NatureOfReview
      can :manage, Faq
      can :manage, Poll
      can :manage, Option
      can :read,   Review
      can :edit,   Review
      can :update, Review
      can :destroy,   Review
      can :manage, User, :role => 'agent'
      can :manage, Supplier
      can :manage, Advertise
      can :manage, Comment
      can :manage, Seo
      can :manage, CompanyPerformance
      can :manage, AbuseReport
    elsif user.is? :agent
      cannot :manage, Resource
      can :manage, Notification
      can :read, MonitorJagent
      cannot :manage, Maintainence
      cannot :manage, Page
      cannot :manage, Resource
      cannot :manage, ResourceType
      cannot :manage, Seo
      can :manage, User, :id=> user.id
      cannot :manage, Faq
      can    :read  , NatureOfReview
      can    :read  , Review
      can    :read  , Industry
      can    :read  , Company
      can    :read  , Town
      can    :read  , Location
      can    :read  , Address
      if Maintainence.first.status 
        can    :edit  , Industry
        can    :edit  , Company
        can    :edit  , Town
        can    :edit  , Location
        can    :edit  , Address
        can    :update  , Industry
        can    :update  , Company
        can    :update  , Town
        can    :update  , Location
        can    :update  , Address
      end
      can    :read,   Review
      can    :edit,   Review
      can    :update, Review
      can    :read,   User, :id => user.id
      can    :edit,   User, :id => user.id
      can    :update, User, :id => user.id
      can    :manage, Comment
      can    :destroy, Review
      can    :manage, Supplier
      cannot :destroy, Supplier
    elsif user.is? :jagent
      cannot :read, MonitorJagent
      can :manage, Notification
      cannot :manage, Resource
      cannot :manage, Maintainence
      cannot :manage, Page
      cannot :manage, Resource
      cannot :manage, ResourceType
      cannot :manage, Faq
      cannot :manage, Seo
      can    :read  , NatureOfReview
      can    :read  , Industry
      can    :read  , Company
      can    :read  , Town
      can    :read  , Location
      if Maintainence.first.status 
         can    :edit  , Industry
         can    :edit  , Company
         can    :edit  , Town
         can    :edit  , Location
         can    :edit  , Address
         can    :update  , Industry
         can    :update  , Company
         can    :update  , Town
         can    :update  , Location
         can    :update  , Address
      end 
      can :manage, User, :id=> user.id
      can    :read,   Review, :jagent_id => user.id
      can    :edit,   Review, :published_date => nil, :jagent_id => user.id
      can    :update, Review, :published_date => nil, :jagent_id => user.id
      can    :read,   User, :id => user.id
      can    :edit,   User, :id => user.id
      can    :update, User, :id => user.id
      can    :manage, Comment
      can    :destroy, Review, :jagent_id => user.id
      can    :read, Supplier
      cannot :edit,Supplier
      cannot :destroy, Supplier
    else
      can    :read,   User, :id => user.id
      can    :edit,   User, :id => user.id
	    can    :update, User, :id => user.id
      can    :manage, Review,:user_id => user.id
      can    :manage, Comment
	  end
  end
end
