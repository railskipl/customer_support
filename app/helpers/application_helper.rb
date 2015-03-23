module ApplicationHelper

  def action_button_helper(text="" ,icon_class = 'icon-dashboard')
    "<i class='#{icon_class}'></i><span> #{text} </span>"
  end

  def generate_path(name)
	  pages = Page.find_all_by_name(name)
  	if pages.count > 0
	  	page_path(pages.first.slug)
	  else
	  	false
	  end
  end

  def account_link
    if user_signed_in?
      link_to "My Account", profile_path, :class=>(@action == "my_account" ? "active":'')
    else
      link_to "My Account", new_user_session_path, :class=>(@action == "my_account" ? "active":'')
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource||=User.new
  end

  def devise_mapping
    @devise_mapping||=Devise.mappings[:user]
  end
end
