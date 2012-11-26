class UsersController < ApplicationController
  
  skip_before_filter :valid_email, :only => [:show, :edit, :update, :validate_email]
  before_filter :is_admin, :except => [:show, :edit, :update, :validate_email]
  before_filter :privilegs, :only => [:show, :edit, :update, :validate_email]
  
  def is_admin
    if !User.current.admin? then
      redirect_to :action => 'show', :id => User.current.id
    end
  end
  
  def privilegs
    unless User.current.id.to_s == params[:id] then
      unless User.current.admin? then
        flash[:alert] = "Spezielle Rechte erforderlich!"
        redirect_to :action => 'show', :id => User.current.id
      end
    end
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new()

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Benutzer erfolgreich erstellt.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user], params[:id])
        format.html { redirect_to @user, notice: 'Benutzer erfolgreicht bearbeitet.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def validate_email
    user = User.find(params[:id])
    unless user.email_valid? then
      unless params[:validation_code] then
        user.validation_code = SecureRandom.hex(10)
        user.save
        UserMailer.send_validate_email(user).deliver
        flash[:notice] = "Validation-Code wurde versandt!"
        redirect_to :action => 'show', :id => user.id
      else
        if user.validation_code == params[:validation_code] then
          user.validation_code = nil
          user.email_valid = true
          user.save
          flash[:notice] = "Emailadresse wurde erfolgreich validiert!"
          redirect_to :action => 'show', :id => user.id
        else
          flash[:alert] = "Validation-Code ist nicht korrekt!"
          redirect_to :action => 'show', :id => user.id
        end
      end
    else
      flash[:notice] = "Emailadresse wurde bereits validiert."
      redirect_to :action => 'show', :id => user.id
    end
  end
end
