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
    @owned_stock = OwnedStock.new(owned_stock_params)
    @owned_stock.base_stock = BaseStock.find(params[:base_stock_id])

    if @owned_stock.save
      current_user.logs.create({
        action: "buy",
        return_amount: @owned_stock.total_value,
        base_stock_id: @owned_stock.base_stock.id,
        group_id: @owned_stock.portfolio.group.id})
      flash[:notice] = "Your order has been executed"
      redirect_to :back
    else
      flash[:warning] = "Your order has not been executed. Please try again"
      redirect_to stock_path(params[:base_stock_id])
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
    params.require(:owned_stock).permit(:buy_price, :quantity, :portfolio_id)
  end
end
