class TasksBaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_counts, except: [:update, :create]

  private

    def get_counts
      @my_count = current_user.tasks.count
      @all_count = Task.count
      @project_count = Project.count
      @contexts = Context.by_name
      @context_count = @contexts.size
      @top_tasks = current_user.top_tasks
    end
end
