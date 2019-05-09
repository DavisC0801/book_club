class UsersController < ApplicationController
  def show
    if User.pluck(:id).include?(params[:id].to_i)
      @user = User.find(params[:id])
    else
      flash[:notice] = "There is no user with that ID"
      redirect_to books_path
    end
  end
end
