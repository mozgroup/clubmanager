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
      
      unless params[:assigned_to].blank? && params[:report_type].blank? 
        @checklists = Checklist.search_assignee_and_type(params[:assigned_to], params[:report_type])
      else
        @checklists = Checklist.by_name
      end
      
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
  
  def duplicate
    old_checklist = Checklist.find(params[:id])
    
    @checklist = Checklist.create(name: "Copy of " + old_checklist.name, frequency: old_checklist.frequency, author_id: old_checklist.author_id, user_id: old_checklist.user_id, days_of_week_mask: old_checklist.days_of_week_mask)
    
    old_checklist.checklist_items.each do |item|
    	@checklist.checklist_items.create(checklist_id: @checklist.id ,name: item.name)
    end
    
    flash[:notice] = 'Checklist was duplicated.'
    redirect_to checklists_url
  end
  
  def reports_daily_incomplete
    @checklists = Checklist.daily_incomplete_items Date.today
    reports_respond_to
  end

  def reports_daily_complete
    @checklists = Checklist.daily_completed_items Date.today
    reports_respond_to
  end

  def reports_weekly_incomplete
    @checklists = Checklist.weekly_incomplete_items Date.today
    reports_respond_to
  end

  def reports_weekly_complete
    @checklists = Checklist.weekly_completed_items Date.today
    reports_respond_to
  end

  def reports_monthly_incomplete
    @checklists = Checklist.monthly_incomplete_items Date.today
    reports_respond_to
  end

  def reports_monthly_complete
    @checklists = Checklist.monthly_completed_items Date.today
    reports_respond_to
  end

  def reports
  	# for top search bar.
	# @report_type = params[:report_type]
# 	@checklists = Checklist.where(user_id: "#{params[:assigned_to]}") if params[:assigned_to]
# 	@checklists ||= Checklist.all
# 	if params[:report_type] == "daily_incomplete"
# 	  @checklists = @checklists.daily_incomplete(Date.today)
# 	elsif params[:report_type] == "daily_complete"
# 	  @checklists = @checklists.daily_completed Date.today
# 	elsif params[:report_type] == "weekly_incomplete"
# 	  @checklists = @checklists.weekly_incomplete Date.today
# 	elsif params[:report_type] == "weekly_complete"
# 	  @checklists = @checklists.weekly_completed Date.today
# 	elsif params[:report_type] == "monthly_incomplete"
# 	  @checklists = @checklists.monthly_incomplete Date.today
# 	elsif params[:report_type] == "monthly_complete"
# 	  @checklists = @checklists.monthly_completed Date.today
# 	else # added by daniel
# 	  @checklists = @checklists.daily_completed Date.today # added by daniel
# 	end

	@checklists = Checklist.search_by_params params
        @report_date = " #{params[:report_date]}"
    reports_respond_to
  end

  private
  
  def download_csv
  	respond_to do |format|
		format.html
		format.csv { send_data Checklist.as_csv }
	end
	
	
  end

    def reports_respond_to
    
		if params[:csv] == "1"
			checklist_csv = CSV.generate do |csv|
				csv << ["List Name", "Frequency", "Assigned To", "Created By"]

				@checklists.each do |hash|
					checklist = hash['checklist']
					csv << [checklist.name, checklist.frequency, checklist.user_full_name, checklist.author_full_name]
				end
			end
			send_data(checklist_csv, :type => 'text/csv', :filename => "checklist_#{Time.now.strftime('%Y%m%d_%H%M')}.csv")
		else	
			respond_to do |format|
				format.html
				format.pdf do
					pdf = ChecklistsPdf.new(@checklists, "Checklists #{@report_date.blank? ? Date.today : @report_date}")

					send_data pdf.render, filename: "checklist_#{Time.now.strftime('%Y%m%d_%H%M')}.pdf", disposition: 'inline'
				end
			end
		end
    end

end
