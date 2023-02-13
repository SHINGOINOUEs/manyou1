class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
    if params[:sort] == "created_at"
      Task.all.order(created_at: :desc)
    end        
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: :desc)
    end  
    if params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
    end

    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.scope_title(params[:task][:title])
        @tasks = @tasks.scope_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.scope_title(params[:task][:title])
      elsif params[:task][:status].present? 
        @tasks = @tasks.scope_status(params[:task][:status])   
      end
    end 
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end  

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id    
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end  
  end

  def show
    @task= Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])    
  end

  def update
    @task= Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end 
  end

    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"タスクを削除しました！"      
    end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline,:status,:priority,:user_id)
  end  

  def set_task
    @task= Task.find(params[:id])
  end  
end
