import 'package:muif_app/models/utilities.dart';
import '../models/bar_code_text.dart';
import '../widgets/widgets.dart';

class MonederoVirtualPage extends StatefulWidget {
  const MonederoVirtualPage({Key? key}) : super(key: key);

  @override
  State<MonederoVirtualPage> createState() => _MonederoVirtualPageState();
}

class _MonederoVirtualPageState extends State<MonederoVirtualPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BarCodeText;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading:
              BackArrowButton(color: Theme.of(context).colorScheme.secondary),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const TitleText(
                    text: 'Monedero Virtual',
                    color: Colors.black,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 550),
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
                                      '/autorizacion',
                                    ),
                              text: 'Recargar saldo monedero MUIF',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
