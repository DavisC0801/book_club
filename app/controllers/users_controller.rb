class UsersController < ApplicationController
  def show
    if User.pluck(:id).include?(params[:id].to_i)
      @user = User.find(params[:id])
      @sorted_param = params[:sort]
    else
      flash[:notice] = "There is no user with that ID"
      redirect_to books_path
    end
  end
end
