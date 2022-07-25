import 'package:flutter/material.dart';

import 'screens/inicio_sesion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: InicioSesion(),
      theme: ThemeData(
        // primaryColor: const Color(0xFF0E2045),
        colorScheme: const ColorScheme.highContrastLight(
          primary: Color(0xFF0E2045),
          secondary: Color(0xFFFFD841),
          background: Colors.white,
        ),
      ),
    );
  }
}
