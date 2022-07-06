# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
    @count = 0
  end

  # GET /items/1 or /items/1.json
  def show; end

  # GET /items/new
  def new
    @category = Category.new
  end

  # GET /items/1/edit
  def edit; end

  def create # rubocop:disable Metrics/MethodLength
    @categories = Category.all
    @category = Category.create(category_params)
    @count = 0

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
      format.js
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
