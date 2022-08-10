import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class SeleccionarInformacionPage extends StatefulWidget {
  const SeleccionarInformacionPage({Key? key}) : super(key: key);

  @override
  State<SeleccionarInformacionPage> createState() =>
      SeleccionarInformacionPageState();
}

class SeleccionarInformacionPageState
    extends State<SeleccionarInformacionPage> {
  @override
  Widget build(BuildContext context) {
    String cantPasajes = '1';
    var items = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(
                text: 'Cantidad de pasajes',
                color: Colors.black,
                size: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: DropdownButton(
                      value: cantPasajes,
                      hint: Text('Número de pasajes'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          cantPasajes = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: TitleText(
                  text: 'Cantidad de cuotas',
                  color: Colors.black,
                  size: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
