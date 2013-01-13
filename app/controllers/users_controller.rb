class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :get_layout_data

  def show
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User sucessfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def search
    users = User.name_search params[:term]

    respond_to do |format|
      format.json { render json: users.collect { |u| { label: u.full_name, value: u.id } }.to_json }
    end
  end

  def change_password
    @user = User.find params[:id]
  end
end
