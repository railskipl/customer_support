class Admin::UsersController < AdminController
  load_and_authorize_resource
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_index_url }
      format.json { head :no_content }
    end
  end
 
  def update_password
    @user ||= current_user
    @user.password = user_params[:password]
    
    if @user.save(validate: false)
      flash[:notice] = "Your password successfully updated."
      sign_in @user, :bypass => true
      redirect_to admin_index_path
    else
      flash[:notice] = "Error in updating password."
      redirect_to admin_change_password_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :salt, :encrypted_password, :first_name, :last_name, :preferred_alias, :gender, :age, :dob, :country, :pobox, :postal_code, :town, :lives_in, :secret_question, :answer, :accpect_t_and_c,:address_line1,:address_line2,:avatar)
  end
end