class Admin::GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_items_path
    end
  end
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
