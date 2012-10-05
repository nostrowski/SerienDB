class SeriesController < ApplicationController
  
  # GET /series
  # GET /series.json
  # GET /series.csv
  def index
    @series = Series.all(:order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @series }
      format.csv { render :csv => @series,  :col_sep => ';' }
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
    
    series.add_season!
    redirect_to series, notice: "Staffel erfolgreich erzeugt!"
  end
  
  def season_remove
    series = Series.find(params[:id])
    
    if series.remove_last_season! then
      redirect_to series, notice: "Staffel erfolgreich entfernt!"
    else
      if series.last_season_pilot? then
        redirect_to series, alert: 'Entfernen der Pilotfolge, auf diesem Weg, nicht erlaubt!'
      else
        redirect_to series, alert: 'Entfernen der Staffel nicht erlaubt! Staffel hat noch Besitzer.'
      end
    end
  end
  
  def save
    series = Series.find(params[:id])
    
    series.update_selected_seasons! params
    redirect_to series, notice: "Staffel erfolgreich gespeichert!"
  end

  # GET /series/new
  # GET /series/new.json
  def new
    @series = Series.new
    @series.added_by = User.current.id

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
        format.html { redirect_to @series, notice: 'Serie wurde erfolgreich erstellt!' }
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
        format.html { redirect_to @series, notice: 'Serie erfolgreich aktualisiert!' }
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
    if @series.removeable? then
      @series.seasons.each do |season|
        season.destroy
      end
      @series.destroy
      redirect_to Series, notice: "Serie erfolgreich entfernt!"
    else
      redirect_to Series, alert: "Entfernen der Serie nicht erlaubt! Staffeln haben noch Besitzer."
    end
  end
end
