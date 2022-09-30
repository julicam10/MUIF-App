// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/screens/iniciar_sesion/eleccion_screen.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

class MontoRecargarPage extends StatefulWidget {
  const MontoRecargarPage({Key? key}) : super(key: key);

  @override
  State<MontoRecargarPage> createState() => _MontoRecargarPageState();
}

int valor = 0;

class _MontoRecargarPageState extends State<MontoRecargarPage> {
  late TextEditingController montoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    montoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    montoController.clear();
  }

  // var montoMask = MaskTextInputFormatter(
  //     mask: "00.000.000", filter: {"0": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading:
            BackArrowButton(color: Theme.of(context).colorScheme.secondary),
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                    child: _inputMonto(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 550.0),
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
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EleccionPage(
                                          valor: valor,
                                        )),
                              );
                            } else {
                              print('Hubo un error');
                            }
                          },
                        ),
                      ),
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

  Widget _inputMonto() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: montoController,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18.0),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Ingrese el valor a recargar',
          labelText: 'Valor a recargar',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        validator: (montoInput) {
          if (montoInput!.isEmpty) {
            return 'Por favor ingresa un valor';
          }
          return null;
        },
        onChanged: (codeInput) {
          String valorString;
          valorString = codeInput;
          valor = int.parse(valorString);
        },
      ),
    );
  }
}
