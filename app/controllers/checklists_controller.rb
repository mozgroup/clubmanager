class ChecklistsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => :new
  before_filter :get_layout_data


  def index
    @checklists = Checklist.without_parent
  end

  def show
  end

  def new
    @checklist = Checklist.new(author_id: current_user.id)
    @checklist.checklist_item_id = params[:checklist_item_id] if params[:checklist_item_id]
  end

  def edit
  end

  def create
    @checklist = Checklist.new(params[:checklist])
    if @checklist.save
      flash[:notice] = 'Checklist was successfully created.'
      redirect_to @checklist
    else
      render 'new'
    end
  end

  def update
    @checklist = Checklist.find(params[:id])

    if @checklist.update_attributes(params[:checklist])
      flash[:notice] = 'Checklist was successfully updated.'
      redirect_to @checklist
    else
      render 'edit'
    end
  end

  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy
    flash[:notice] = 'Checklist was deleted.'
    redirect_to checklists_url
  end

end
