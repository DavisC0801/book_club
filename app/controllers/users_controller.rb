class UsersController < ApplicationController
  def show
    if User.pluck(:id).include?(params[:id].to_i)
      @user = User.find(params[:id])
    else
      redirect_to book_path
    end
  end
end
