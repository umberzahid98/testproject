# frozen_string_literal: true

# cart controller
class CartsController < ApplicationController
  def index
    @user_inline_items=user_inline_item

end


private
def user_inline_item
  if current_user
    return user_inline_items = InlineItem.where(user_id: current_user.id)
  else
    cart = Cart.find_by(id: session[:cart_id])
      if cart
      return user_inline_items = InlineItem.where(cart: session[:cart_id])
      end
  end
end

end
