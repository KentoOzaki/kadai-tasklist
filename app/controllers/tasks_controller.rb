class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :edit, :destroy, :update]
    
    
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
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
    
    def task_params
        params.require(:task).permit(:content ,:status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
    
end
