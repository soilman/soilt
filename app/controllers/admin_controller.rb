class AdminController < Devise::RegistrationsController
  before_filter :admin?
  skip_before_filter :require_no_authentication, only: [:new, :create]

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "#{@user.email} created"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render "new"
    end
  end

  def edit
    @user = User.where(email: params[:email]).first
  end

  def update
    @user = User.find(params[:user][:user_id])

    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.email} updated"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to edit_user_registration_path(@user)
    end
  end

  private

    def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :admin

    )
  end

end
