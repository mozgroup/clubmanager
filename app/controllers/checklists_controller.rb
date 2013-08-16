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

  def reports
    @report_type = params[:report_type]
    @checklists = Checklist.where(user_id: "#{params[:assigned_to]}") if params[:assigned_to]
    @checklists ||= Checklist.all
    if params[:report_type] == "daily_incomplete"
      @checklists = @checklists.daily_incomplete(Date.today)
    elsif params[:report_type] == "daily_complete"
      @checklists = @checklists.daily_completed Date.today
    elsif params[:report_type] == "weekly_incomplete"
      @checklists = @checklists.weekly_incomplete Date.today
    elsif params[:report_type] == "weekly_complete"
      @checklists = @checklists.weekly_completed Date.today
    elsif params[:report_type] == "monthly_incomplete"
      @checklists = @checklists.monthly_incomplete Date.today
    elsif params[:report_type] == "monthly_complete"
      @checklists = @checklists.monthly_completed Date.today
    end
    reports_respond_to
  end

  private

    def reports_respond_to
      #caller_method = caller[0][/`([^']*)'/, 1]
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ChecklistsPdf.new(@checklists, @report_type.humanize)
          send_data pdf.render, filename: "#{@report_type}_#{Time.now.strftime('%Y%m%d_%H%M')}.pdf", disposition: 'inline'
        end
      end
    end

end
