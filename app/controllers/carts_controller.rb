# frozen_string_literal: true

# cart controller
class CartsController < ApplicationController
  def index
    @user_inline_items=user_inline_item
    @order = Order.new
  end

private
def user_inline_item
  if current_user
     user_inline_items = InlineItem.where(user_id: current_user.id)
  else
    cart = Cart.find_by(id: session[:cart_id])
      if cart
       user_inline_items = InlineItem.where(cart: session[:cart_id])
      end
  end
  user_inline_items
end
def user_inline_item_id
  if current_user
     user_inline_items = InlineItem.where(user_id: current_user.id).where(status: "non-checkedout")
  else
    cart = Cart.find_by(id: session[:cart_id])
      if cart
        user_inline_items = InlineItem.where(cart: session[:cart_id])
      end
  end
  user_inline_items.pluck(:id)
end
  helper_method :user_inline_item
  helper_method :user_inline_item_id
end
