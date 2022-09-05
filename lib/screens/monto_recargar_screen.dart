import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/utilities.dart';
import '../widgets/widgets.dart';
import 'screens_screen.dart';

class MontoRecargarPage extends StatefulWidget {
  const MontoRecargarPage({Key? key}) : super(key: key);

  @override
  State<MontoRecargarPage> createState() => _MontoRecargarPageState();
}

final montoController = TextEditingController();
final _formKey = GlobalKey<FormState>();

int valor = 0;

class _MontoRecargarPageState extends State<MontoRecargarPage> {
  @override
  void dispose() {
    super.dispose();
    montoController.clear();
  }

  CollectionReference instanciaUsuario =
      FirebaseFirestore.instance.collection('usuarios');

  // Se puede borrar
  // updateUser() {
  //   return instanciaUsuario
  //       .doc('correo@correo.com')
  //       .collection('monedero')
  //       .doc('unico')
  //       .update({'saldo': montoController.text})
  //       .then((value) => print("Saldo actualizado"))
  //       .catchError((error) => print("Error al actualizar el saldo: $error"));
  // }

  // var montoMask = MaskTextInputFormatter(
  //     mask: "00.000.000", filter: {"0": RegExp(r'[0-9]')});
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
        controller: montoController,
        // inputFormatters: [montoMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20.0),
        validator: (montoInput) {
          if (montoInput!.isEmpty) {
            return 'Por favor ingresa un valor';
          }
          return null;
        },
        onChanged: (codeInput) {
          setState(() {
            String valorString;
            valorString = codeInput;
            valor = int.parse(valorString);
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
