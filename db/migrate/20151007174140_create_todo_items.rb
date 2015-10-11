class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :title
      t.text :description
      t.timestamps null: false
      t.integer :user_id
      t.integer :status
      t.integer :share_with 	       			
    end
  end
end
