class ChecklistsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource :only => [:new,:index]
  before_filter :get_layout_data


  def index
    unless params[:query].blank?
      @checklists = Checklist.search_for params[:query]
    else
      @checklists = Checklist.without_parent
    end
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

  def reports_daily_incomplete
    @checklists = Checklist.daily_incomplete Date.today
    reports_respond_to
  end

  def reports_daily_complete
    @checklists = Checklist.daily_completed Date.today
    reports_respond_to
  end

  def reports_weekly_incomplete
    @checklists = Checklist.weekly_incomplete Date.today
    reports_respond_to
  end

  def reports_weekly_complete
    @checklists = Checklist.weekly_completed Date.today
    reports_respond_to
  end

  def reports_monthly_incomplete
    @checklists = Checklist.monthly_incomplete Date.today
    reports_respond_to
  end

  def reports_monthly_complete
    @checklists = Checklist.monthly_completed Date.today
    reports_respond_to
  end

  private

    def reports_respond_to
      caller_method = caller[0][/`([^']*)'/, 1]
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ChecklistsPdf.new(@checklists, caller_method.split(/_(.*)$/)[1].humanize)
          send_data pdf.render, filename: "#{caller_method}_#{Time.now.strftime('%Y%m%d_%H%M')}.pdf", disposition: 'inline'
        end
      end
    end

end
