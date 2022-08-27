import 'package:muif_app/widgets/widgets.dart';

import '../models/utilities.dart';

class ComprobantePagoPage extends StatefulWidget {
  const ComprobantePagoPage({Key? key}) : super(key: key);

  @override
  State<ComprobantePagoPage> createState() => _ComprobantePagoPageState();
}

String fecha = 'dd/mm/aaaa';
String correo = 'ejemplo@correo.com';
String cantidadPasajes = 'xxx';
String totalPagar = '\$xxxx COP';

class _ComprobantePagoPageState extends State<ComprobantePagoPage> {
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: TitleText(
                  text: 'Comprobante de pago',
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Container(
                  height: 490,
                  width: 330,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: const [
                        _BannerRowWidget(),
                        Divider(
                          color: Colors.black,
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        _FilaOrigenDestino(),
                        _ColumnaFecha(),
                        _ColumnaCorreo(),
                        _ColumnaCantidadPasajes(),
                        _ColumnaTotalPagar(),
                        _ColumnaSaldo(),
                      ],
                    ),
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

class _BannerRowWidget extends StatelessWidget {
  const _BannerRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
          child: const Image(
            image: AssetImage('assets/img/iconFlutter.png'),
          ),
        ),
        Column(
          children: const [
            TitleText(text: 'MUIF APP', color: Colors.black, size: 20.0),
            NormalText(
                text: 'Número de pago: XXX', color: Colors.black, size: 15.0)
          ],
        ),
        const Icon(Icons.check_circle, color: Colors.green, size: 40.0),
      ],
    );
  }
}

class _FilaOrigenDestino extends StatelessWidget {
  const _FilaOrigenDestino({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              TitleText(text: 'La Pampa', color: Colors.black, size: 20.0),
              TitleText(text: 'Terminal', color: Colors.black, size: 20.0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Container(
                  width: 135.0,
                  height: 1.0,
                  color: Colors.black45,
                ),
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ColumnaFecha extends StatelessWidget {
  const _ColumnaFecha({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleText(text: 'Fecha', color: Colors.black, size: 20.0),
          NormalText(text: fecha, color: Colors.black, size: 15.0)
        ],
      ),
    );
  }
}

class _ColumnaCorreo extends StatelessWidget {
  const _ColumnaCorreo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(text: 'Correo', color: Colors.black, size: 20.0),
          NormalText(text: correo, color: Colors.black, size: 15.0)
        ],
      ),
    );
  }
}

class _ColumnaCantidadPasajes extends StatelessWidget {
  const _ColumnaCantidadPasajes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(
              text: 'Cantidad de pasajes', color: Colors.black, size: 20.0),
          NormalText(text: cantidadPasajes, color: Colors.black, size: 15.0)
        ],
      ),
    );
  }
}

class _ColumnaTotalPagar extends StatelessWidget {
  const _ColumnaTotalPagar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(
              text: 'Total a pagar', color: Colors.black, size: 20.0),
          NormalText(text: totalPagar, color: Colors.black, size: 15.0)
        ],
      ),
    );
  }
}

class _ColumnaSaldo extends StatelessWidget {
  const _ColumnaSaldo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(text: 'Tu saldo', color: Colors.black, size: 20.0),
          NormalText(text: totalPagar, color: Colors.black, size: 15.0)
        ],
      ),
    );
  }
}
