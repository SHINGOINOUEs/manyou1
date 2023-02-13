class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :login_already, only: [:new]
  before_action :user_check, only: [:show]  

  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end  

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id      
      redirect_to user_path(@user.id)
    else
      render :new
    end  
  end

  def show
    @user = User.find(params[:id])
    redirect_to tasks_path unless @user.id == current_user.id    
  end

  private

  def user_params
    params.require(:user).permit(:admin, :name, :email, :password, :password_confirmation)
  end

  def login_already
    if current_user
      flash[:notice]="ログイン中です"
      redirect_to user_path(current_user.id)
    end
  end

  def user_check
    if current_user.id != params[:id].to_i
      flash[:notice]="アクセス権限がありません"
      redirect_to tasks_path
    end
  end

  def require_owner
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only manage your own account"
      redirect_to tasks_path(@user.id)
    end
  end

end
