class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @record = Item.find_by(name: @content)
    if @record
      redirect_to item_path(@record.id)
    else
     redirect_to request.referer
    end
  end
end
