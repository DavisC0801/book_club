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

  def destroy
    author = Author.find(params[:id])
    author_name = author.name
    author.books.each do |book|
      book.destroy
    end
    author.destroy

    flash[:notice] = "#{author_name} was deleted"
    redirect_to books_path
  end
end