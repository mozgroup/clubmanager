class UsersController < ApplicationController
  before_filter :authenticate_user!

  def search
    users = User.name_search params[:term]

    respond_to do |format|
      format.json { render json: users.collect { |u| { label: u.full_name, value: u.id } }.to_json }
    end
  end
end
