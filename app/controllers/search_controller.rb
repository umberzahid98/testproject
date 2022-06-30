# frozen_string_literal: true

# search controller
class SearchController < ApplicationController

  def index
    @query = Item.ransack(params[:q])
    # it will return all of the search reslts
    @items = @query.result(distinct: true)

    @cat = []

  end
end
