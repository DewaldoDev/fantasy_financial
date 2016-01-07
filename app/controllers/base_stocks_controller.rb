class BaseStocksController < ApplicationController
  before_action :find_base_stock, only: [:show, :edit, :update, :create, :destroy]

  def index
    if params[:name] || params[:ticker]
      @base_stocks = BaseStock.where("LOWER(name) LIKE LOWER(?)", "%#{params[:name]}%").where("LOWER(ticker) LIKE LOWER(?)", "%#{params[:ticker]}%").where("LOWER(sector) LIKE LOWER(?)", "%#{params[:sector]}%").paginate(:page => params[:page])
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
    @related_stocks = BaseStock.where(industry: @base_stock.industry).where.not(ticker: @base_stock.ticker).order(percent_change: :desc).limit(10)
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
