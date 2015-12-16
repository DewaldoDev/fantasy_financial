class BaseStocksController < ApplicationController
  before_action :find_base_stock, only: [:show, :edit, :update, :create, :destroy]

  def index
    if params[:ticker]
      @base_stocks = BaseStock.where("LOWER(ticker) LIKE LOWER(?)", "%#{params[:ticker]}%")
    else
      @base_stocks = BaseStock.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @base_stock = BaseStock.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def find_base_stock
    @base_stock = BaseStock.find(params[:id])
  end
end
