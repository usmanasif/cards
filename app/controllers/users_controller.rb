class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.except_user(current_user)
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream
      end
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :role).tap { |params| params[:role] = params[:role].to_i }
    end
end
