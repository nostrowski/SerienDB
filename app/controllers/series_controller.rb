class SeriesController < ApplicationController
  
  #before_filter :validate_session
  
  # GET /series
  # GET /series.json
  def index
    @series = Series.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @series }
    end
  end

  # GET /series/1
  # GET /series/1.json
  def show
    @series = Series.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @series }
    end
  end
  
  def season_add
    series = Series.find(params[:id])
    new_number = 0
    series.seasons.each do |season|
      new_number = season.number if new_number < season.number
    end
    Season.create(:series_id => series.id, :number => new_number+1)
    redirect_to :controller => "series", :action => "show", :id => series.id, notice: "Staffel erfolgreich erzeugt!"
  end
  
  def season_remove
    series = Series.find(params[:id])
    delete_number = 0
    series.seasons.each do |season|
      delete_number = season.number if delete_number < season.number
    end
    series.seasons.find_by_number(delete_number).destroy
    redirect_to :controller => "series", :action => "show", :id => series.id, notice: "Staffel erfolgreich entfernt!"
  end
  
  def save
    series = Series.find(params[:id])
    series.seasons.each do |season|
      season.users.delete(current_user)
      season.users << current_user if params["s#{season.number}"]
    end
    redirect_to :controller => "series", :action => "show", :id => series.id, notice: "Staffel erfolgreich gespeichert!"
  end

  # GET /series/new
  # GET /series/new.json
  def new
    @series = Series.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @series }
    end
  end

  # GET /series/1/edit
  def edit
    @series = Series.find(params[:id])
  end

  # POST /series
  # POST /series.json
  def create
    @series = Series.new(params[:series])

    respond_to do |format|
      if @series.save
        format.html { redirect_to @series, notice: 'Series was successfully created.' }
        format.json { render json: @series, status: :created, location: @series }
      else
        format.html { render action: "new" }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /series/1
  # PUT /series/1.json
  def update
    @series = Series.find(params[:id])

    respond_to do |format|
      if @series.update_attributes(params[:series])
        format.html { redirect_to @series, notice: 'Series was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @series.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  # DELETE /series/1.json
  def destroy
    @series = Series.find(params[:id])
    @series.destroy

    respond_to do |format|
      format.html { redirect_to series_index_url }
      format.json { head :no_content }
    end
  end
end
