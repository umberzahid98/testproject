class InlineItemsController < ApplicationController
  before_action :set_inline_item, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[create]

  def index

    @inline_items = InlineItem.all
  end
  def update


    user = !current_user.nil?

    respond_to do |format|
      if(user)
        if @inline_item.update(inline_item_params)
          @user_inline_items=user_inline_item
        end
      else

        @inline_item.quantity = inline_item_params[:quantity]
        @inline_item.save(:validate => false)
          if @inline_item
            @user_inline_items=user_inline_item
          end
      end

      # if @inline_item.update(inline_item_params)
      #   @user_inline_items=user_inline_item
      #   format.html { redirect_to inline_item_url(@inline_item), notice: ' inlineitem was successfully updated.' }
      #   format.json { render :show, status: :ok, location: @inline_item }
      # else
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @inline_item.errors, status: :unprocessable_entity }
      # end
      format.js
    end
  end

  def new
    @inline_item = Inline_Item.new
  end
  def destroy
    @inline_item.destroy
    @user_inline_items = user_inline_item

    respond_to do |format|
      format.html { redirect_to inline_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
  def create
    # byebug
    @items = Item.all
    @item = Item.new
    if current_user
      @inline_item = InlineItem.create(inline_item_params.merge!(cart: @cart.id, user_id: current_user.id))
    else
      @inline_item = InlineItem.create(inline_item_params.merge!(cart: @cart.id))
      @inline_item.save(validate: false)
    end
    # if i use js it perfoms only the first time
    # respond_to do |format|

    #   format.js
    # end
    redirect_to '/items'

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inline_item


    if current_user
      @inline_item = InlineItem.find(params[:id])

    else
      puts "in else of not current user"
      # @inline_item = InlineItem.find(inline_item_params[:id])

      @inline_item = InlineItem.find(params[:id])

    end


  end

  def set_cart

    @cart = Cart.find_by(id: session[:cart_id])
    if @cart
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
  # before change sin update this is the user_inline_item used
  # def user_inline_item
  #   if current_user
  #     return user_inline_items = InlineItem.where(user_id: current_user.id)
  #   else
  #     cart = Cart.find_by(id: session[:cart_id])
  #       if cart
  #       return user_inline_items = InlineItem.where(cart: session[:cart_id])
  #       end
  #   end
  # end

  def user_inline_item
    if current_user
      return user_inline_items = InlineItem.where(user_id: current_user.id ).where(status: "non-checkedout")
    else
      cart = Cart.find_by(id: session[:cart_id])
        if cart
          return user_inline_items = InlineItem.where(cart: session[:cart_id])
        end
    end
  end

  # Only allow a list of trusted parameters through.
  def inline_item_params

    params.require(:inline_item).permit(:quantity, :price, :item_id, :id)
  end
end
