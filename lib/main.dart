import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_api/pages/home_screen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que Flutter esté inicializado
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors
              .blue, // Usando primarySwatch para definir el color principal
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
