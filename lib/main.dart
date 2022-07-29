import 'package:flutter/material.dart';
import 'package:muif_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: InicioSesionPage.routeName,
      routes: {
        InicioSesionPage.routeName: (_) => const InicioSesionPage(),
        RecuperarContrasenaPage.routeName: (_) =>
            const RecuperarContrasenaPage(),
        RegistroPage.routeName: (_) => const RegistroPage(),
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
