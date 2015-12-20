class BaseStocksController < ApplicationController
  before_action :find_base_stock, only: [:show, :edit, :update, :create, :destroy]

  def index
    if params[:ticker]
      @base_stocks = BaseStock.where("LOWER(ticker) LIKE LOWER(?)", "%#{params[:ticker]}%").paginate(:page => params[:page])
    elsif params[:name]
      @base_stocks = BaseStock.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%").paginate(:page => params[:page])
    else
      @base_stocks = BaseStock.paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @portfolios = current_user.portfolios
    @owned_stock = OwnedStock.new
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
