class SeasonsController < ApplicationController
  
  # GET /seasons
  # GET /seasons.json
  # GET /seasons.csv
  def index
    @seasons = Season.all()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @seasons }
      format.csv { render :csv => @seasons,  :col_sep => ';' }
    end
  end
  
end