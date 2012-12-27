class CheckListsController < ApplicationController
  # GET /check_lists
  # GET /check_lists.json
  def index
    @check_lists = CheckList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @check_lists }
    end
  end

  # GET /check_lists/1
  # GET /check_lists/1.json
  def show
    @check_list = CheckList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @check_list }
    end
  end

  # GET /check_lists/new
  # GET /check_lists/new.json
  def new
    @check_list = CheckList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @check_list }
    end
  end

  # GET /check_lists/1/edit
  def edit
    @check_list = CheckList.find(params[:id])
  end

  # POST /check_lists
  # POST /check_lists.json
  def create
    @check_list = CheckList.new(params[:check_list])

    respond_to do |format|
      if @check_list.save
        format.html { redirect_to @check_list, notice: 'Check list was successfully created.' }
        format.json { render json: @check_list, status: :created, location: @check_list }
      else
        format.html { render action: "new" }
        format.json { render json: @check_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /check_lists/1
  # PUT /check_lists/1.json
  def update
    @check_list = CheckList.find(params[:id])

    respond_to do |format|
      if @check_list.update_attributes(params[:check_list])
        format.html { redirect_to @check_list, notice: 'Check list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @check_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_lists/1
  # DELETE /check_lists/1.json
  def destroy
    @check_list = CheckList.find(params[:id])
    @check_list.destroy

    respond_to do |format|
      format.html { redirect_to check_lists_url }
      format.json { head :no_content }
    end
  end
end
