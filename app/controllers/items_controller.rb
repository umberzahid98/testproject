# frozen_string_literal: true

# items controller
class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items or /items.json
  def index
    if current_user
      if current_user.admin?
        @items = Item.all
      else
        @items=Item.permited_items
      end
    end

    unless current_user
        @items = Item.permited_items
    end

    @item = Item.new
    @inline_item = InlineItem.new
    if current_user
      @cart = Cart.find_by(id: session[:cart_id])
      InlineItem.where(cart: session[:cart_id]).update_all(user_id: current_user.id) if @cart
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id

    end

  end

  # GET /items/1 or /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items or /items.json
  def create # rubocop:disable Metrics/MethodLength
    @item = Item.create(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :description, :price, :image, category_ids: [])
  end
end
