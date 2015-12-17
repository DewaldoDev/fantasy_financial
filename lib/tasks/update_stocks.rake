desc "Grab stock price data using Yahoo Finance API"
task update_stock_prices: [:environment] do
	BaseStock.update_prices
end

# Start a new Cron task
# Pass in the rake commanc and full path to the rake task
# The Whenever gem is much less error prone than Cron
# Install the gem, call "wheneverize" on the CL, write tasks in schedule.rb