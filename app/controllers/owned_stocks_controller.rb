class OwnedStocksController < ApplicationController
  before_action :find_owned_stock, only: [:show, :edit, :update, :create, :destroy]
  def index
    @owned_stocks = OwnedStock.all
  end
  def show
  end
  def new
    @owned_stock = OwnedStock.new
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
  def find_owned_stock
    @owned_stock = OwnedStock.find(params[:id])
  end
end
