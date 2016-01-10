class PortfoliosController < ApplicationController
before_action :find_portfolio, only:[:show, :edit, :update, :destroy]

  def index
    @portfolios = Portfolio.all
  end

  def show
    @portfolio.calculate_value
    @owned_stocks = @portfolio.owned_stocks.all
    @equity = @portfolio.calculate_equity || 0
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
      cash = @owned_stock.sell_stock(params[:stock_quantity].to_i)
      current_user.logs.create({action: "sell", return_amount: cash, base_stock_id: @owned_stock.base_stock.id})
      @portfolio.cash += cash
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
