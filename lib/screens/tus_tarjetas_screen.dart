import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/screens/screens_screen.dart';
import 'package:muif_app/widgets/widgets.dart';

import '../models/bar_code_text.dart';

class TusTarjetasPage extends StatefulWidget {
  const TusTarjetasPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TusTarjetasPage> createState() => _TusTarjetasPageState();
}

class _TusTarjetasPageState extends State<TusTarjetasPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BarCodeText;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading: BackArrowButton(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        body: Column(
          children: [
            const Center(
              child: TitleText(
                text: 'Tus tarjetas registradas',
                color: Colors.black,
                size: 20,
              ),
            ),
            // Cards
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: '',
                    style: GoogleFonts.sourceSerifPro(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamed(
                                context,
                                '/registrarTarjeta',
                              ),
                        text: ' Registar nueva tarjeta',
                        style: GoogleFonts.sourceSerifPro(
                          color: const Color(0xFF3D73DD),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // BotonWidget(
            //   backgroundColor: Theme.of(context).colorScheme.secondary,
            //   textColor: Theme.of(context).colorScheme.primary,
            //   text: 'Continuar',
            //   navigator:
            //       args.barCodeText == '' ? '' : '/seleccionarInformacion',
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: SizedBox(
                height: 50,
                width: 270,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: args.barCodeText.length == 1
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                    primary: args.barCodeText.length == 1
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    textStyle: GoogleFonts.nunito(
                      fontSize: args.barCodeText.length == 1 ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: args.barCodeText.length == 1
                      ? const Text('Primero escanea un QR')
                      : const Text('Continuar'),
                  onPressed: () {
                    args.barCodeText.length == 1
                        ? null
                        : Navigator.pushNamed(
                            context, '/seleccionarInformacion');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: Container(
            //     height: 100,
            //     width: 350,
            //     decoration: BoxDecoration(
            //       color: Colors.grey,
            //       borderRadius: BorderRadius.circular(20.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: const Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
            //     ),
            //   ),
            // ),