class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @count=0
  end
end
