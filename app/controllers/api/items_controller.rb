class Api::ItemsController < ApplicationController

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
    def item_params
      params.require(:item).permit(:parent_id, :title, :content, :position)
    end
end
