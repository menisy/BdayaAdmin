class TasksController < ApplicationController

	def new
		@task = Task.new
	end

	def assign_task
		@user = User.where(:id=> params[:user_id])
		current_user.assign_task(@user, params[:deadline], params[:title], params[:details])
	end

	def done
		@task = Task.find(params[:task_id])
		current_user.mark_task_done(@task)
		redirect_to action: "index"
	end

	def reopen
		@task = Task.find(params[:id])
		current_user.reopen_task(@task)
	end

	def request_extension
		@task = Task.find(params[:task_id])
	end

	def index
		@done_tasks = current_user.get_done_tasks
		@pending_tasks = current_user.get_pending_tasks
	end

	def sent_tasks
		@sent_tasks = current_user.get_sent_tasks
	end
end