class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.html { render 'users/my_portfolio'}
          format.js { render partial: 'users/result' }
        end
      else
        flash.now[:danger] = "You have entered an incorrect symbol"
        render partial: 'users/result'
      end
    else
      flash.now[:danger] = "You have entered an empty search string"
      render partial: 'users/result'
    end
  end
end
