module TodoItemsHelper

  def get_shared_user(id)
    User.find(id.to_i).name
  end
  
  def get_task_status(status)
    status.to_i == 0 ? "Pending" : "Finished"
  end
    
end
