class TasksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @contexts = Context.by_name
  end
end
