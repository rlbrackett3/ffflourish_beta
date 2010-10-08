class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @title = "all ffflourish members"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = "hello #{current_user.first_name}"
  end
  
end
