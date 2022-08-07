import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class InfoTarjetaPage extends StatefulWidget {
  const InfoTarjetaPage({Key? key}) : super(key: key);

  @override
  State<InfoTarjetaPage> createState() => _InfoTarjetaPageState();
}

class _InfoTarjetaPageState extends State<InfoTarjetaPage> {
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
                  const TitleText(
                    text: 'Ingrese la información de la tarjeta',
                    color: Colors.black,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      height: 100.0,
                      width: 300,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          helperMaxLines: 16,
                          hintText: 'Número de tarjeta',
                          label: Text('Número de tarjeta'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
