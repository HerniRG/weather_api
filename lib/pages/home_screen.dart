import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/services/weather_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherServices();
  Weather? _currentWeather;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final city = await _weatherService.getCity();
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _currentWeather = weather;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching weather: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: _currentWeather == null
            ? const CircularProgressIndicator()
            : _buildWeatherDisplay(),
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    return FadeIn(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _buildBackgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.place,
                  size: 40,
                  color: Colors.white,
                ),
                FittedBox(
                  child: Text(
                    _currentWeather!.cityName,
                    style: GoogleFonts.alegreya(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Lottie.asset(
                _weatherService.getLottieWeather(_currentWeather?.condition)),
            Text(
              '${_currentWeather!.temperature.round()}°C',
              style: GoogleFonts.alegreya(
                fontSize: 100,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            _weatherService.getBackgroundImage(_currentWeather?.condition)),
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.4),
          BlendMode.darken,
        ),
      ),
    );
  }
}
