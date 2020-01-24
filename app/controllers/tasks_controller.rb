class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    
    def index
        if logged_in?
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end
    
    def show
        
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'succeeded to create new task'
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = "faild to create new task"
            render :new
        end
    end
    
    def edit
        
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "succeeded to update task"
            redirect_to @task
        else
            flash[:danger] = "faild to update task"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "deletion was completed"
        redirect_to tasks_url
        
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content ,:status)
    end
    
end
