class MonthlySummariesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_layout_data

  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    @monthly_summary = MonthlySummary.new
  end

  def edit
  end

  def create
    @monthly_summary = MonthlySummary.new(params[:monthly_summary])
    if @monthly_summary.save
      flash[:notice] = 'A monthly summary was successfully created.'
      redirect_to @monthly_summary
    else
      render 'new'
    end
  end

  def update
    @monthly_summary = MonthlySummary.find(params[:id])
    if @monthly_summary.update_attributes(params[:monthly_summary])
      flash[:notice] = 'The monthly summary was successfully updated.'
      redirect_to @monthly_summary
    else
      render 'edit'
    end
  end

  def destroy
    monthly_summary = MonthlySummary.find(params[:id])
    monthly_summary.destroy
    flash[:notice] = 'The monthly summary was deleted.'
    redirect_to monthly_summaries_url
  end

  def forecast
    @club = Club.find params[:club_id]
    @current_date = Time.parse(params[:month])
    @monthly_summary = MonthlySummary.for_club(params[:club_id]).for_month(@current_date.beginning_of_month).first
    @completed_days = @monthly_summary.daily_summaries.count

    @membership_cash_to_date = @monthly_summary.cash_to_date('membership')
    @membership_projected = @monthly_summary.projected_cash('membership')
    @membership_goal = @monthly_summary.membership_goal
    @membership_over_under = @monthly_summary.over_under('membership')
    @training_cash_to_date = @monthly_summary.cash_to_date('training')
    @training_projected = @monthly_summary.projected_cash('training')
    @training_goal = @monthly_summary.training_goal
    @training_over_under = @monthly_summary.over_under('training')
    @juice_bar_cash_to_date = @monthly_summary.cash_to_date('juice_bar')
    @juice_bar_projected = @monthly_summary.projected_cash('juice_bar')
    @juice_bar_goal = @monthly_summary.juice_bar_goal
    @juice_bar_over_under = @monthly_summary.over_under('juice_bar')
    @nursery_cash_to_date = @monthly_summary.cash_to_date('nursery')
    @nursery_projected = @monthly_summary.projected_cash('nursery')
    @nursery_goal = @monthly_summary.nursery_goal
    @nursery_over_under = @monthly_summary.over_under('nursery')

    @cash_to_date_total = @membership_cash_to_date + @training_cash_to_date + @juice_bar_cash_to_date + @nursery_cash_to_date
    @projected_total = @membership_projected + @training_projected + @juice_bar_projected + @nursery_projected
    @goal_total = @membership_goal + @training_goal + @juice_bar_goal + @nursery_goal
    @over_under_total = @membership_over_under + @training_over_under + @juice_bar_over_under + @nursery_over_under

    @membership_draft_cash = @monthly_summary.membership_draft_cash_to_date
    @training_draft_cash = @monthly_summary.training_draft_cash_to_date
    @total_draft_cash = @membership_draft_cash + @training_draft_cash
    @total_draft_projected = @monthly_summary.membership_draft_expected + @monthly_summary.training_draft_expected

  end
end
