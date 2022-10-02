// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muif_app/screens/screens_screen.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

class SeleccionarInformacionPage extends StatefulWidget {
  const SeleccionarInformacionPage({Key? key, this.codigoBuseta})
      : super(key: key);

  final codigoBuseta;

  @override
  State<SeleccionarInformacionPage> createState() =>
      SeleccionarInformacionPageState();
}

class SeleccionarInformacionPageState
    extends State<SeleccionarInformacionPage> {
  String selectedValuePasajes = "1";
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

  String fecha = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  @override
  Widget build(BuildContext context) {
    print(
        'Valor arguments - seleccionar info: ${widget.codigoBuseta.toString()}');
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
                    print('valor seleccionado: $selectedValuePasajes');
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
                child: SizedBox(
                  height: 50,
                  width: 270,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                    ),
                    child: TitleText(
                      text: 'Continuar',
                      color: Theme.of(context).colorScheme.primary,
                      size: 20.0,
                    ),
                    onPressed: () {
                      int cantidadPasajes = int.parse(selectedValuePasajes);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PagarPasajePage(
                            cantidadPasajes: cantidadPasajes,
                            totalAPagar: cantidadPasajes * 1850,
                            numeroBuseta: widget.codigoBuseta.toString(),
                            fecha: fecha,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
