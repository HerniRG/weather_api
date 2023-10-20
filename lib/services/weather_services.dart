// Resumen: Este archivo contiene la implementación de los servicios de clima que utilizan la API de OpenWeatherMap para obtener información meteorológica. Incluye métodos para obtener el clima de una ciudad específica y para obtener la ubicación actual del usuario y devolver la ciudad correspondiente.
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/models/weather_model.dart';

class WeatherServices {
  static String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey = '622233f891038a910f8c343051969cc0';

  // Obtiene el clima de una ciudad específica utilizando la API de OpenWeatherMap
  Future<Weather> getWeather(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al cargar el tiempo');
    }
  }

  // Obtiene la ubicación actual del usuario y devuelve la ciudad correspondiente utilizando la API de geolocalización
  Future<String> getCity() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemark.first.locality;
    return city!;
  }

  String getLottieWeather(String? condition) {
    if (condition == null) return "assets/sunny.json";
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/cloud.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/rain.json";
      case 'thunderstorm':
        return "assets/thunder.json";
      case 'clear':
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  String getBackgroundImage(String? condition) {
    if (condition == null) return "assets/sunny.jpeg";
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/cloud.jpeg";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/rain.jpeg";
      case 'thunderstorm':
        return "assets/thunder.jpeg";
      case 'clear':
        return "assets/sunny.jpeg";
      default:
        return "assets/sunny.jpeg";
    }
  }
}
