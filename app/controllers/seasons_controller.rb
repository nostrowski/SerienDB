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
  
  # GET /seasons/1/edit
  def edit
    @season = Season.find(params[:id])
  end
  
  # PUT /seasons/1
  # PUT /seasons/1.json
  def update
    @season = Season.find(params[:id])

    respond_to do |format|
      if @season.update_attributes(params[:season])
        flash[:notice] = "Staffel erfolgreich aktualisiert!"
        format.html { redirect_to :controller => "series", :action => "show", :id => @season.series.id }
      else
        format.html { render action: "edit" }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end
  
end