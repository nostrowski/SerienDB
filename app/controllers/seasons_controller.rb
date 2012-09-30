class SeasonsController < ApplicationController
  
  def index
    @seasons = Season.all()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @series }
    end
  end
  
end