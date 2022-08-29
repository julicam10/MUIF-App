import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:muif_app/screens/screens_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      // builder: (context, child) => ResponsiveWrapper.builder(
      //   child,
      //   maxWidth: 1200,
      //   minWidth: 480,
      //   defaultScale: true,
      //   breakpoints: [
      //     const ResponsiveBreakpoint.resize(480, name: MOBILE),
      //     const ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //     const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      //   ],
      // ),
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
        '/seleccionarInformacion': (context) =>
            const SeleccionarInformacionPage(),
        '/pagarPasaje': (context) => const PagarPasajePage(),
        '/monederoVirtual': (context) => const MonederoVirtualPage(),
        '/autorizacion': (context) => const AutorizacionPage(),
        '/comprobantePago': (context) => const ComprobantePagoPage(),
        '/montoRecargar': (context) => const MontoRecargarPage(),
        '/eleccion': (context) => const EleccionPage(),
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
