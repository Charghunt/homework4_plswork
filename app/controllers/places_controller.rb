class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"],"user_id" => @current_user["id"] })
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["place"]["name"]
    @place["id"] = @current_user["id"]
    @place.save
    redirect_to "/places"
  end

  def edit
    @place = Place.find_by({ "id" => params["id"] })
  end

  def update
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user
      @place["name"] = params["place"]["name"]
      @place.save
    else
      flash["notice"] = "You must be logged in."
    end
    redirect_to "/places/#{@place["id"]}"
  end
  
  def destroy
    @place = Place.find_by({ "id" => params["id"] })
    if @current_user
      @place.destroy
      redirect_to "/places"
    else
      flash["notice"] = "You must be logged in."
      redirect_to "/places/#{@place["id"]}"
    end
  end

end

