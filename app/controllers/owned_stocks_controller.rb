class OwnedStocksController < ApplicationController
  before_action :find_owned_stock, only: [:show, :edit, :update, :destroy]

  def index
    @owned_stocks = OwnedStock.all
  end

  def show
  end

  def new
    @owned_stock = OwnedStock.new
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @owned_stock = @portfolio.owned_stocks.new(owned_stock_params)
    @owned_stock.base_stock = BaseStock.where(ticker: params[:base_stock_ticker])

    if @owned_stock.save
      flash[:notice] = "Your order has been executed"
      redirect_to portfolio_path(@portfolio)
    else
      flash[:warning] = "Your order has not been executed. Please try again"
      render '/base_stocks/show'
    end
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

  def owned_stock_params
    params.require(:owned_stock).permit(:buy_price, :quantity, :buy_date)
  end
end
