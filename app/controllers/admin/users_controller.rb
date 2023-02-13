class Admin::UsersController < ApplicationController
  before_action :if_not_admin  
  before_action :set_admin_user, only:[:show, :edit, :destroy, :update]  


  def index  
    @users = User.select(:id, :name, :email, :admin).order(created_at: :asc)    
  end

  def new
    @user = User.new    
  end    

  def create
    @users = User.new(user_params)
    if @users.save
      redirect_to admin_users_path,notice: "ユーザーを新しく登録しました。"
    else
      render :new
    end                    
  end

  def show
    @user = User.find(params[:id])    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update  
    @user = User.find(params[:id])    
    if @users.update(user_params) 
      redirect_to admin_users_path, notice: "ユーザー情報を変更しました。"
    else
      render :edit  
    end
  end

  def destroy
    if @users.admin == true
      @users.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました。"
    else
      redirect_to admin_users_path, notice: "最低1ユーザーは管理者権限を持つ必要があります。"   
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)  
  end

  def  if_not_admin
    redirect_to  tasks_path(current_user.id)  unless  current_user.admin?
  end  

  def set_admin_user
    @users = User.find(params[:id])
  end

end
