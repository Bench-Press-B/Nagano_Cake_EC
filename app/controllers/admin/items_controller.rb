class Admins::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def item_params
    params.require(:item).permit(:image, :name, :explanation, :genre_ID, :non_taxed_price, :is_active)
  end

end
