class TagsController < ApplicationController
  # GET /tags
  def index
    @tags = Tag.all(:order => "priority DESC")

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  def create
    @tag = Tag.new(params[:tag])
    
    increment_priorities = Tag.find_by_priority(0) != nil

    respond_to do |format|
      if @tag.save
        if increment_priorities then
          Tag.all.each do |tag|
            unless tag == @tag then
              tag.priority += 1
              tag.save
            end
          end
        end
        format.html { redirect_to :tags, notice: 'Tag erfolgreich erstellt.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /tags/1
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to :tags, notice: 'Tag erfolgreich gespeichert.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /tags/1
  def destroy
    @tag = Tag.find(params[:id])
    if @tag.priority == 0 then
      @tag.destroy
      Tag.all.each do |tag|
        tag.priority -= 1
        tag.save
      end
    end

    respond_to do |format|
      format.html { redirect_to tags_url }
    end
  end
  
  # PUT /tags/1/priority_up
  def priority_up
    @tag = Tag.find(params[:id])
    @tag.priority_up!
    redirect_to :controller => "tags"
  end
  
  # PUT /tags/1/priority_down
  def priority_down
    @tag = Tag.find(params[:id])
    @tag.priority_down!
    redirect_to :controller => "tags"
  end
end
