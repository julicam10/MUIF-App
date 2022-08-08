import 'package:flutter/material.dart';
import 'package:muif_app/screens/screens_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioSesionPage(),
        '/recuperarContrasena': (context) => const RecuperarContrasenaPage(),
        '/registro': (context) => const RegistroPage(),
        '/home': (context) => const HomePage(),
        '/registrarTarjeta': (context) => const RegistrarTarjetaPage(),
        '/infoTarjeta': (context) => const InfoTarjetaPage(),
        '/tusTarjetas': (context) => const TusTarjetasPage(),
        '/barCode': (context) => const BarCodePage(),
      },
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(
          primary: Color(0xFF0E2045),
          secondary: Color(0xFFFFD841),
          background: Colors.white,
        ),
      ),
    );
  }
}
