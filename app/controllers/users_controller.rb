class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def all_reports
    @users = User.all
  end



end
