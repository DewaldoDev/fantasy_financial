class BaseStocksController < ApplicationController
  before_action :find_base_stock, only: [:show, :edit, :update, :create, :destroy]
  def index
    @base_stocks = BaseStock.all
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
