class Api::ItemsController < ApplicationController

  def create
    @item = Item.new(item_params)
    if @item.save
      render "api/items/_item"
    else
      head 422
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update item_params
      render "api/items/_item"
    else
      head 400
    end
  end

  def item_params
    params.require(:item).permit(:title, :content, :position, :parent_id)
  end

end
