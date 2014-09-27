class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      sign_in(resource)
      if resource.guest_token.present?
        review = Review.find_by_guest_token(resource.guest_token)
        if review.review_type == "complaint"
          redirect_to new_review_path(:id => review.id, :review_type => "complaint")
        else
          redirect_to new_review_path(:id => review.id, :review_type => "compliment")
        end
      else
        respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
      end
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end
end
