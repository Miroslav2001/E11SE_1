class Weather {
  final double temp;
  final int weatherCode;
  final List hourlyTime;
  final List hourlyTemp;
  final List hourlyCode;

  Weather({required this.temp, required this.weatherCode,required this.hourlyTime,
    required this.hourlyTemp,required this.hourlyCode});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temp: json['current_weather']['temperature'].toDouble(),
        weatherCode: json["current_weather"]["weathercode"],hourlyTime: json["hourly"]["time"],
      hourlyTemp: json["hourly"]["temperature_2m"],hourlyCode: json["hourly"]["weathercode"]);
  }
}

class Fire_Index {
  final double temp;
  final double windspeed;
  final humidity;
  final precipitation_days;
  final wind_direction;

  Fire_Index({required this.temp, required this.windspeed,
    required this.humidity, required this.precipitation_days,
    required this.wind_direction});

  factory Fire_Index.fromJson(Map<String, dynamic> json) {
    return Fire_Index(
        temp: json['current_weather']['temperature'].toDouble(),
        windspeed: json['current_weather']['windspeed'].toDouble(),
        humidity: json['hourly']['relativehumidity_2m'][0],
        precipitation_days: json['daily']['precipitation_hours'][0],
        wind_direction: json['hourly']['winddirection_10m'][0]);


  }
}
