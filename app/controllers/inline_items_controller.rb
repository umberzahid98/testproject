class InlineItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[create]

  def index
    byebug
    @inline_items = @InlineItem.all
  end

  def show

  end

  def new
    @inline_item = Inline_Item.new
  end

  def create

    @inline_item = InlineItem.create(inline_item_params)


  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inline_item_params
    params.require(:inline_item).permit(:quantity, :price, :item_id)
  end
end
