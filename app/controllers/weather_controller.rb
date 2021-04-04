class WeatherController < ApplicationController

  def index
  end

  def search
    zipcode = find_zip(params[:zipcode])
  end
end
