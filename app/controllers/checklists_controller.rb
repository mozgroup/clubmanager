class ChecklistsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @checklists = Checklist.all
  end

  def show
    @checklist = Checklist.find(params[:id])
  end

  def new
    @checklist = Checklist.new(author_id: current_user.id)
  end

  def edit
    @checklist = Checklist.find(params[:id])
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
