class Weather {
  final String cityName;
  final double temperature;
  final String condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      condition: json['weather'][0]['main'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'temp': temperature,
      'condition': condition,
    };
  }
}
