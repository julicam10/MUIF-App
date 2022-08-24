import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class PagarPasajePage extends StatefulWidget {
  const PagarPasajePage({Key? key}) : super(key: key);

  @override
  State<PagarPasajePage> createState() => _PagarPasajePageState();
}

class _PagarPasajePageState extends State<PagarPasajePage> {
  bool _estaActivo = false;
  @override
  Widget build(BuildContext context) {
    String valor = '${'xxxx'} COP';
    String cantidadPasajes = 'X';
    String cantidadCuotas = 'X';
    String numerosFinales = 'XXX';
    String banco = 'XXX';

    return Scaffold(
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: TitleText(
                text: 'Revisa que todo este correcto',
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: TitleText(
                text: '${'xxxx'} COP',
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              children: const [
                NormalText(
                  text: 'Cantidad de pasajes: ',
                  color: Colors.grey,
                  size: 15.0,
                ),
                NormalText(text: 'X', color: Colors.black, size: 15.0)
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              children: const [
                NormalText(
                  text: 'Cantidad de cuotas: ',
                  color: Colors.grey,
                  size: 15.0,
                ),
                NormalText(text: 'X', color: Colors.black, size: 15.0)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Center(
              child: TitleText(
                text: 'Método de pago',
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              children: const [
                NormalText(
                    text: 'Terminado en ', color: Colors.grey, size: 15.0),
                TitleText(text: 'XXXX', color: Colors.black, size: 15.0)
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              children: const [
                NormalText(text: 'Banco ', color: Colors.grey, size: 15.0),
                TitleText(text: 'XXXX', color: Colors.black, size: 15.0)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
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
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CheckboxListTile(
                      checkColor: Theme.of(context).colorScheme.primary,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: const NormalText(
                        text: 'Estoy de acuerdo en realizar la transferencia',
                        color: Colors.white,
                        size: 20.0,
                      ),
                      value: _estaActivo,
                      onChanged: (value) => setState(() {
                        _estaActivo = value ?? true;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 230.0),
                    child: BotonWidget(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.primary,
                      text: 'Pagar',
                      navigator: '/comprobantePago',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
