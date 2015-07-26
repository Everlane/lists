class ItemsController < ApplicationController

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: "Yay!"
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :content, :position)
    end
end
