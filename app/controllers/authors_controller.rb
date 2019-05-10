class AuthorsController < ApplicationController
  def show
    if Author.pluck(:id).include?(params[:id].to_i)
      @author = Author.find(params[:id])
    else
      flash[:notice] = "There is no author with that ID"
      redirect_to books_path
    end
  end

  def index
  end
end