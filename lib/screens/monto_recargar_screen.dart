import '../models/utilities.dart';
import '../widgets/widgets.dart';

class MontoRecargarPage extends StatefulWidget {
  const MontoRecargarPage({Key? key}) : super(key: key);

  @override
  State<MontoRecargarPage> createState() => _MontoRecargarPageState();
}

final codigoController = TextEditingController();
String valor = '';

class _MontoRecargarPageState extends State<MontoRecargarPage> {
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
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const Center(
                    child: TitleText(
                      text: 'Monto a recargar',
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: _inputMonto()),
                  Padding(
                    padding: const EdgeInsets.only(top: 500.0),
                    child: BotonWidget(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.primary,
                      text: 'Continuar',
                      navigator: '/productoDestino',
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

  Container _inputMonto() {
    return Container(
      height: 50,
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(50.0)),
      child: TextFormField(
        controller: codigoController,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20.0),
        onChanged: (codeInput) {
          setState(() {
            valor = codeInput;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Ingrese el valor a transferir',
        ),
      ),
    );
  }
}
