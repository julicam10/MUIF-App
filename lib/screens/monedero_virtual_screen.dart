import 'package:muif_app/models/utilities.dart';
import '../models/bar_code_text.dart';
import '../widgets/widgets.dart';

class MonederoVirtualPage extends StatefulWidget {
  const MonederoVirtualPage({Key? key}) : super(key: key);

  @override
  State<MonederoVirtualPage> createState() => _MonederoVirtualPageState();
}

String description = "Movilidad Urbana | Inteligente en Fusagasugá";

String newDescription = description.replaceAll("|", "\n");

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
          child: Column(
            children: [
              const TitleText(
                text: 'Monedero Virtual MUIF',
                color: Colors.black,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 180,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Stack(
                    children: [
                      const SizedBox(
                        height: 700,
                        width: 700,
                        child: Image(
                          image: AssetImage('assets/img/fondoTarjetAMuif.jpeg'),
                          fit: BoxFit.cover,
                          height: 500,
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: SizedBox(
                                    height: 80.0,
                                    width: 200.0,
                                    child: TitleText(
                                      text:
                                          'Movilidad Urbana Inteligente en Fusagasugá',
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 45.0),
                                  child: Container(
                                    height: 65.0,
                                    width: 65.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/img/iconFlutter.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TitleText(
                              text: 'Saldo: \$X.XXX',
                              color: Theme.of(context).colorScheme.primary,
                              size: 17.0,
                            ),
                            TitleText(
                              text: 'Código: XXXXXXXXXX',
                              color: Theme.of(context).colorScheme.primary,
                              size: 17.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: TitleText(
                  text: 'Historial de movimientos',
                  color: Colors.black,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 330),
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
                  child: Hero(
                    tag: 'boton',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
