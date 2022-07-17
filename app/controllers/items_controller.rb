# frozen_string_literal: true

# items controller
class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items or /items.json
  def index
    if current_user
      @items = if current_user.admin?
          Item.all.order(created_at: :desc)
        else
          Item.permited_items.order(created_at: :desc)
        end
    end
    @items = Item.permited_items.order(created_at: :desc) unless current_user
    @item = Item.new
    @inline_item = InlineItem.new
  end

  # POST /items or /items.json
  def create
    authorize Item
    if current_user
      @items = if current_user.admin?
          Item.all.order(created_at: :desc)
        else
          Item.permited_items.order(created_at: :desc)
        end
    end
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.js{ flash.now[:notice] = "item created successfully" }
      else
        format.js{ flash.now[:notice] = "item is not created" }
      end

    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    authorize Item
    @items=Item.all.order(created_at: :desc)
    respond_to do |format|

      if @item.update(item_params)
        format.js{ flash.now[:notice] = "item updated successfully" }
      else

        format.js{ flash.now[:notice] = "item not updated!!" }
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :description, :price, :status, :image,:search, category_ids: [])
  end
end
