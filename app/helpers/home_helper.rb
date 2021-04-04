module HomeHelper

  def find_aqi_zip(zipcode)
    request_aqi_api("https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{(zipcode)}&distance=25&API_KEY=#{(aqi_api_key)}")
  end

  def find_weather_zip(zipcode)
    request_weather_api("https://api.openweathermap.org/data/2.5/forecast?zip=#{(zipcode)},us&appid=#{(weather_api_key)}")
  end

  def request_aqi_api(url)
    @aqiurl = url
    @aqiuri = URI(@aqiurl)
    @aqiresponse = Net::HTTP.get(@aqiuri)
    @aqioutput = JSON.parse(@aqiresponse)

    if @aqioutput.empty?
      @air_quality = "Error"
      @ReportingArea = "Error"
      @ReportingState = "Error"
      @AQIQuality = "Error"
    elsif !@aqioutput
      @air_quality = "Error"
      @ReportingArea = "Error"
      @ReportingState = "Error"
      @AQIQuality = "Error"
    else
      @air_quality = @aqioutput[0]['AQI']
      @ReportingArea = @aqioutput[0]['ReportingArea']
      @ReportingState = @aqioutput[0]['StateCode']
      @AQIQuality = @aqioutput[0]['Category']['Name']
    end
  end

    
  def request_weather_api(url)
    @owmurl = url
    @owmuri = URI(@owmurl)
    @owmresponse = Net::HTTP.get(@owmuri)
    @owmoutput = JSON.parse(@owmresponse)

    if @owmoutput.empty?
      @weatherdescriptiontoday = "Error"
      @weathertemptoday = "Error"
      @weatherdescriptiontmrw = "Error"
      @weathertemptmrw = "Error"
    elsif !@owmoutput
      @weatherdescriptiontoday = "Error"
      @weathertemptoday = "Error"
      @weatherdescriptiontmrw = "Error"
      @weathertemptmrw = "Error"
    else
      @weatherdescriptiontoday = @owmoutput['list'][0]['weather'][0]['description']
      @weathertemptoday = ((@owmoutput['list'][0]['main']['temp'] - 273.15) * 9/5 + 32).round()
      @weatherdescriptiontmrw = @owmoutput['list'][1]['weather'][0]['description']
      @weathertemptmrw = ((@owmoutput['list'][1]['main']['temp'] - 273.15) * 9/5 + 32).round()
    end
  end

end
