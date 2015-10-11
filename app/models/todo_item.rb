class TodoItem < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title, :description
	validates_uniqueness_of :title, :message => " already present" 
end
