class DailySummariesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_monthly_summary

  def show
    @daily_summary = DailySummary.find params[:id]
  end

  def new
    @daily_summary = @monthly_summary.daily_summaries.build
  end

  def edit
    @daily_summary = DailySummary.find params[:id]
  end

  def update
    @daily_summary = DailySummary.find params[:id]
    if @daily_summary.update_attributes(params[:daily_summary])
      flash[:sucess] = "Daily Summary successfully updated!"
      redirect_to @monthly_summary
    else
      render 'edit'
    end
  end

  def create
    @daily_summary = @monthly_summary.daily_summaries.build(params[:daily_summary])
    if @daily_summary.save
      flash[:sucess] = "Daily summary successfully updated!"
      redirect_to @monthly_summary
    else
      render 'new'
    end
  end

  def show
    @daily_summary = DailySummary.find params[:id]
  end

  def destroy
    @daily_summary = DailySummary.find params[:id]
  end

  private

    def get_monthly_summary
      @monthly_summary = MonthlySummary.find params[:monthly_summary_id]
    end
end
