require 'http'

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties
  def index
    @properties = Property.all.sort_by {|pr| pr.rating}.reverse
    render json: @properties
  end

  # GET /properties/1
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  def set_fake_coordinate
    if @property.latitude.present?
      @property.fake_latitude = @property.latitude + [-0.0003, -0.0002, -0.0001, 0.0001, 0.0002, 0.0003].sample
      @property.fake_longitude = @property.longitude + [-0.0003, -0.0002, -0.0001, 0.0001, 0.0002, 0.0003].sample
      @property.save
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  def create
    @property = Property.create(property_params)
    set_fake_coordinate
    if @property.save
      # redirect_to @property, notice: "Property was successfully created."
      render json: @property, status: :created, location: @property
    else
      # render :new, status: :unprocessable_entity
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
    #   redirect_to @property, notice: "Property was successfully updated."
    # else
    #   render :edit, status: :unprocessable_entity
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy
    # redirect_to properties_url, notice: "Property was successfully destroyed.", status: :see_other
  end

  # def rating_count
  #   @rating = HTTP.get("https://api.mapbox.com/search/v1/forward/%E3%82%AF%E3%83%AA%E3%83%8B%E3%83%83%E3%82%AF?language=ja&limit=50&proximity=132.754883,35.366889&bbox=132.74488300000002,35.356889,132.764883,35.376889&country=JP&access_token=pk.eyJ1IjoiaXJpbmFzayIsImEiOiJjbDIwOHhrbm0wdWJlM2pxZDNvN3A5NHNzIn0.M37Dun7-7tjVc9C0O82lpw").to_s
  #   # HTTP.get("https://github.com").to_s
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:title, :price, :rooms, :bathrooms, :avatar, :address, :longitude, :latitude, :fake_latitude, :fake_longitude, :rating)
    end
end
