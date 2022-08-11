import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class RegistrarTarjetaPage extends StatefulWidget {
  const RegistrarTarjetaPage({Key? key}) : super(key: key);

  @override
  State<RegistrarTarjetaPage> createState() => _RegistrarTarjetaPageState();
}

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
                  _SelectCardWidget(icon: Icons.credit_card),
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
                  _SelectCardWidget(icon: Icons.credit_score_rounded),
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
              padding: const EdgeInsets.only(top: 300.0),
              child: BotonWidget(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
                text: 'Continuar',
                navigator: '/infoTarjeta',
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
  }) : super(key: key);

  final IconData icon;

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
        onPressed: () {
          //Crear variable de boton seleccionado
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
