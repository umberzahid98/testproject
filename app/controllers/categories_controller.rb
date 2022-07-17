# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  def index
    authorize Category
    @categories = Category.all
    @category = Category.new
    @count = 0
  end

  def create
    authorize Category
    @categories = Category.all
    @category = Category.new(category_params)
    @count = 0

    respond_to do |format|
      if @category.save
        format.js{ flash.now[:notice] = "Category created successfully" }
      else
        format.js{ flash.now[:notice] = "Category not created!" }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end
