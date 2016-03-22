class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def all_reports
    @projects = Project.all
    @user_emails = User.all.inject({}) { |memo, user| memo.merge(user.id => user.email) }
  end



end
