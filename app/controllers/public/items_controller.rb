class Public::ItemsController < ApplicationController

  def index
    @item = Item.all
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def genre
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @item = Item.where(genre_id: @genre.id)
    @items = @item.page(params[:page]).per(8)
  end


end
