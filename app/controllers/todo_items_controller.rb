class TodoItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]
  
  def index
    binding.pry
    @todo_items = User.find(current_user.id).todo_items
    @shared_items = TodoItem.find_by_share_with(current_user.id)
    @todo_item = @todo_items << @shared_items if !@shared_items.nil?
    @user_list = User.all
  end

  def show
  end

  def new
    @todo_item = TodoItem.new
    @users_list = User.all.map{ |user| user.name }  
  end

  def edit
    @users_list = User.all.map{ |user| user.name }
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.status = 0  # Default status is pending unless Finished
    @todo_item.user_id = current_user.id
    @todo_item.share_with = User.find_by_name(params[:user].to_s).id unless params[:user].empty?
    respond_to do |format|
      if @todo_item.save        
        format.html { redirect_to todo_items_url, notice: 'Todo item was successfully created.' }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        if params[:user].empty?
          @todo_item.update_attributes(:share_with => nil)
        else
          @todo_item.update_attributes(:share_with => User.find_by_name(params[:user].to_s).id)
        end         
        format.html { redirect_to todo_items_url, notice: 'Todo item was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else 
        format.html { render :edit }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_todo_item
      if params[:id].to_s == "mark_done"
        @todo_item = TodoItem.find(params[:format].to_i)
        @todo_item.status = 1       # Marking Status as Finished 
        @todo_item.save!
        redirect_to todo_items_url, notice: 'Status was successfully modified.'
      else 
        @todo_item = TodoItem.find(params[:id])  
      end   
    end

    def todo_item_params
      params.require(:todo_item).permit(:title, :description, :status)
    end
end
