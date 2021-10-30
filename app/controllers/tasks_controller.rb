class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if current_user.admin = true
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(2)
      @tasks = Task.all.order(expiration_date: :desc).page(params[:page]).per(2) if params[:sort_expired] == 'true' 
      @tasks = Task.all.order(priority: :desc).page(params[:page]).per(2) if params[:sort_priority] == 'true'
    
    else  

    @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page]).per(2)
    @tasks = current_user.tasks.all.order(expiration_date: :desc).page(params[:page]).per(2) if params[:sort_expired] == 'true' 
    @tasks = current_user.tasks.all.order(priority: :desc).page(params[:page]).per(2) if params[:sort_priority] == 'true' 

    end 
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @labels = Label.all
  end

  # GET /tasks/1/edit
  def edit
    @labels = Label.all
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search 
    @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    session[:search] = {'name' => params[:search_title], 'status' => params[:search_status], 'priority' => params[:search_priority]}
   
    if params[:search_title].present?
      if params[:search_status].present?
        if params[:search_priority].present?
          if params[:search_label].present?
          @tasks = current_user.tasks.search_by_title(params[:search_title]).search_by_status(params[:search_status]).order_by_priority(params[:search_priority]).label_search(params[:search_label]).kaminari params[:page] 
          else 
            @tasks = current_user.tasks.search_by_title(params[:search_title]).search_by_status(params[:search_status]).order_by_priority(params[:search_priority]).kaminari params[:page] 
          end
        else
          @tasks = current_user.tasks.search_by_title(params[:search_title]).search_by_status(params[:search_status]).kaminari params[:page] 
        end
      elsif params[:search_priority].present?
        @tasks = current_user.tasks.search_by_title(params[:search_title]).order_by_priority(params[:search_priority]).kaminari params[:page] 
      else
        @tasks = current_user.tasks.search_by_title(params[:search_title]).kaminari params[:page] 

      end


    elsif params[:search_status].present?
      
      if params[:search_priority].present?
        if params[:search_label].present?
          @tasks = current_user.tasks.search_by_status(params[:search_status]).order_by_priority(params[:search_priority]).label_search(params[:search_label]).kaminari params[:page] 
        else
           @tasks = current_user.tasks.search_by_status(params[:search_status]).order_by_priority(params[:search_priority]).kaminari params[:page]
        end
          
      else
        @tasks = current_user.tasks.search_by_status(params[:search_status]).kaminari params[:page] 
      end

      
    elsif params[:search_priority].present?
      
      if params[:search_status].present?
        if params[:search_label].present?
          @tasks = current_user.tasks.order_by_priority(params[:search_priority]).search_by_status(params[:search_status]).label_search(params[:search_label]).kaminari params[:page]
        else
          @tasks = current_user.tasks.order_by_priority(params[:search_priority]).search_by_status(params[:search_status]).kaminari params[:page] 
        end
        
      else
        @tasks = current_user.tasks.order_by_priority(params[:search_priority]).kaminari params[:page] 
      end


    elsif params[:search_label].present?
      
      if params[:search_status].present?
        if params[:search_priority].present?
          @tasks = current_user.tasks.order_by_priority(params[:search_priority]).search_by_status(params[:search_status]).label_search(params[:search_label]).kaminari params[:page]
        else
          @tasks = current_user.tasks.label_search(params[:search_label]).search_by_status(params[:search_status]).kaminari params[:page] 
        end
        
      else
        @tasks = current_user.tasks.label_search(params[:search_label]).kaminari params[:page] 
      end
      
    else
      @tasks = current_user.tasks
    end
  
    # @labels = Label.where(user_id: nil).or(Label.where(user_id: current_user.id))
    
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description, :expiration_date, :status, :priority,label_ids: [])
    end
end
