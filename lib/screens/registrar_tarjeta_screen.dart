// ignore_for_file: avoid_print

import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class RegistrarTarjetaPage extends StatefulWidget {
  const RegistrarTarjetaPage({Key? key}) : super(key: key);
  @override
  State<RegistrarTarjetaPage> createState() => _RegistrarTarjetaPageState();
}

String tipoTarjeta = '';

class _RegistrarTarjetaPageState extends State<RegistrarTarjetaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading:
              BackArrowButton(color: Theme.of(context).colorScheme.secondary),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleText(
              text: '¿Qué tipo de tarjeta quieres registrar?',
              color: Colors.black,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 40.0),
              child: Row(
                children: const [
                  _SelectCardWidget(
                    icon: Icons.credit_card,
                    tipoTarjetaWidget: 'Crédito',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TitleText(
                        text: 'Tarjeta de crédito',
                        color: Colors.black,
                        size: 17.0),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 40.0),
              child: Row(
                children: const [
                  _SelectCardWidget(
                    icon: Icons.credit_score_rounded,
                    tipoTarjetaWidget: 'Debito',
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TitleText(
                      text: 'Tarjeta de debito',
                      color: Colors.black,
                      size: 17.0,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 330.0),
              child: Hero(
                tag: 'boton',
                child: SizedBox(
                  height: 50,
                  width: 270,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Theme.of(context).colorScheme.primary,
                      primary: Theme.of(context).colorScheme.secondary,
                      textStyle: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Continuar'),
                    onPressed: () {
                      print('Tipo tarjeta es: $tipoTarjeta');
                      if (tipoTarjeta.isNotEmpty) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/infoTarjeta',
                          arguments: tipoTarjeta,
                        );
                      } else {
                        print('Seleccione un tipo de tarjeta');
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectCardWidget extends StatelessWidget {
  const _SelectCardWidget({
    Key? key,
    required this.icon,
    required this.tipoTarjetaWidget,
  }) : super(key: key);

  final IconData icon;
  final String tipoTarjetaWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 105,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        //Poner el color cuando se selecciona
        splashColor: Colors.red,
        onPressed: () {
          tipoTarjeta = tipoTarjetaWidget;
          print('Tipo tarjeta es: $tipoTarjeta');
        },
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 72,
        ),
      ),
    );
  }
}
