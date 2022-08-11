import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class PagarPasajePage extends StatefulWidget {
  const PagarPasajePage({Key? key}) : super(key: key);

  @override
  State<PagarPasajePage> createState() => _PagarPasajePageState();
}

class _PagarPasajePageState extends State<PagarPasajePage> {
  @override
  Widget build(BuildContext context) {
    String valor = '${'xxxx'} COP';
    String cantidadPasajes = 'X';
    String cantidadCuotas = 'X';
    String numerosFinales = 'XXX';
    String banco = 'XXX';
    bool _value = false;
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
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    activeColor: Colors.red,
                    selected: _value,
                    value: _value,
                    onChanged: (bool? valueSeleceted) {
                      setState(() {
                        _value == valueSeleceted;
                      });
                    },
                    title: const NormalText(
                        text: 'Estoy de acuerdo en realizar la transferencia',
                        color: Colors.white,
                        size: 15.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
