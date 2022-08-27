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
  String selectedValuePasajes = "1";
  String selectedValueCuotas = "1";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "1", child: Text("1")),
      const DropdownMenuItem(value: "2", child: Text("2")),
      const DropdownMenuItem(value: "3", child: Text("3")),
      const DropdownMenuItem(value: "4", child: Text("4")),
      const DropdownMenuItem(value: "5", child: Text("5")),
      const DropdownMenuItem(value: "6", child: Text("6")),
      const DropdownMenuItem(value: "7", child: Text("7")),
      const DropdownMenuItem(value: "8", child: Text("8")),
      const DropdownMenuItem(value: "9", child: Text("9")),
    ];
    return menuItems;
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: TitleText(
                  text: 'Número de pasajes',
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 110.0, vertical: 10.0),
              child: SizedBox(
                height: 60.0,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  value: selectedValuePasajes,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValuePasajes = newValue!;
                    });
                  },
                  items: dropdownItems,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Center(
                child: Hero(
                  tag: 'boton',
                  child: BotonWidget(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.primary,
                    text: 'Continuar',
                    navigator: '/pagarPasaje',
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
