class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])

    @order_detail.update(order_detail_params)
    @order = @order_detail.order


    if @order_detail.status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "制作ステータスの更新をしました。"
      @order.save
    end

    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :status, :quantity, :item_id)
  end
end
