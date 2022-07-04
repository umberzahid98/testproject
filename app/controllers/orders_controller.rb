# frozen_string_literal: true

# orders controller

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
      if current_user.admin?
        @orders = Order.all
      else
        @orders = Order.user_orders(current_user.id)
      end



  end

  def show; end

  def new

    @order = Order.new
  end

  def create # rubocop:disable Metrics/MethodLength

    @order = current_user.orders.create(inline_item_ids: user_inline_item_id, price: calculate_bill )
    @user_cart = current_user.inline_items.where(status: "non-checkedout").update_all(status: "checkedout")

    respond_to do |format|

      if @order.save

        format.html { redirect_to order_url(@order), notice: 'order was successfully created.' }

        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])

  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :status, :price )
  end

  def calculate_bill
    user_inline_item.sum('price*quantity')
  end


  def user_inline_item
    if current_user
       user_inline_items = InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")

    else
      cart = Cart.find_by(id: session[:cart_id])
        if cart
          user_inline_items = InlineItem.where(cart: session[:cart_id]).where(status: "non-checkedout")
        end
    end
    #  cart items
    user_inline_items
  end

  def user_inline_item_id
    if current_user
       user_inline_items = InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")

    else
      cart = Cart.find_by(id: session[:cart_id])
        if cart
          user_inline_items = InlineItem.where(cart: session[:cart_id]).where(status: "non-checkedout")
        end
    end
    #  ids of cart items
    user_inline_items.pluck(:id)
  end
end
