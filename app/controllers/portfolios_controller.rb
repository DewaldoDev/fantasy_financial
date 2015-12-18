class PortfoliosController < ApplicationController
before_action :find_portfolio, only:[:show, :edit, :update, :destroy]

  def index
    @portfolios = Portfolio.all
  end

  def show
    @owned_stocks = @portfolio.owned_stocks.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
  end

  def edit
  end

  def update
    if params[:stock_id] && params[:stock_quantity]
      @owned_stock = @portfolio.owned_stocks.find(params[:stock_id])
      @portfolio.cash += @owned_stock.sell_stock(params[:stock_quantity].to_f)
      @portfolio.save
    end
  end

  def destroy
  end

  private
  def find_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:current_value, :cash)
  end

end
