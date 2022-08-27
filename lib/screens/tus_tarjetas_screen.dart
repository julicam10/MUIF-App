import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

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
              padding: const EdgeInsets.only(top: 650),
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
          ],
        ),
      ),
    );
  }
}
