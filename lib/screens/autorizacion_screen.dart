import '../models/utilities.dart';
import '../widgets/widgets.dart';

class AutorizacionPage extends StatefulWidget {
  const AutorizacionPage({Key? key}) : super(key: key);

  @override
  State<AutorizacionPage> createState() => AutorizacionPageState();
}

String text =
    "Se le informa que está apunto de recargar su monedero virtual MUIF. \n Tenga en cuenta que el saldo que transfiera solo será valido para pagar pasajes del transporte público del municipio de Fusagasugá, Cundinamarca.";

class AutorizacionPageState extends State<AutorizacionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
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
                text: 'Autorización',
                color: Colors.black,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 335),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: NormalText(
                            text: text, color: Colors.white, size: 18.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Hero(
                          tag: 'boton',
                          child: BotonWidget(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context).colorScheme.primary,
                            text: 'Continuar',
                            navigator: '/montoRecargar',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
