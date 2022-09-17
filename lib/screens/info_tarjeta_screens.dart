// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InfoTarjetaPage extends StatefulWidget {
  const InfoTarjetaPage({Key? key}) : super(key: key);

  @override
  State<InfoTarjetaPage> createState() => _InfoTarjetaPageState();
}

class Tarjeta {
  final String numero;
  final String nombre;
  final String fecha;
  final String codigo;
  final String saldo;
  Tarjeta(this.numero, this.nombre, this.fecha, this.codigo, this.saldo);
}

class _InfoTarjetaPageState extends State<InfoTarjetaPage> {
  var cardMask = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});

  var dateMask =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});

  var codeMask =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  // var saldoMask = MaskTextInputFormatter(
  //     mask: "00.000.000", filter: {"0": RegExp(r'[0-9]')});

  String nombre = '';
  String card = '';
  String fecha = '';
  String codigo = '';
  String tipo = '';
  int saldo = 0;
  final String tarjetaId = const Uuid().v1();
  final formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cardController = TextEditingController();
  final _fechaController = TextEditingController();
  final _codigoController = TextEditingController();
  final _saldoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //Agregar aca el correo del usuario
  CollectionReference instancia =
      FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nombreController.dispose();
    _cardController.dispose();
    _fechaController.dispose();
    _codigoController.dispose();
    _saldoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> insertarTarjeta() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('tarjetas')
        .doc(tarjetaId)
        .set({
          'codigo': _codigoController.text,
          'fecha': _fechaController.text,
          'nombre': _nombreController.text,
          'numero': _cardController.text,
          'saldo': int.parse(_saldoController.text),
          'tipo': tipo
        })
        .then((value) => print("Tarjeta agregada"))
        .catchError((error) => print("Error al agregar la tarjeta: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    tipo = args.toString();
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
                  const TitleText(
                    text: 'Ingrese la información de la tarjeta',
                    color: Colors.black,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TitleText(
                      text: 'Tipo de tarjeta: ${args.toString()}',
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  _creditCard(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: _inputNombre(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: _inputCard(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: _inputSaldo(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Container(
                      child: _inputDate(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Container(
                      child: _inputCode(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
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
                              openDialog('¡Tarjeta registrada con exito!');
                              insertarTarjeta();
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              openDialog('¡Hubo un error! Intente de nuevo');
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _creditCard(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 700,
              width: 700,
              child: Image(
                image: AssetImage('assets/img/fondoTarjeta.png'),
                fit: BoxFit.cover,
                height: 500,
                color: Color.fromRGBO(255, 255, 255, 0.12),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 0.0),
                        child: SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: Image(
                            image: AssetImage('assets/img/creditCard.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 150.0, bottom: 45.0),
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: Image(
                            image: AssetImage('assets/img/iconoTarjeta.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TitleText(
                    text: card == '' ? 'Número de tarjeta' : card,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 17.0,
                  ),
                  TitleText(
                    text: nombre == '' ? 'Nombre del titular' : nombre,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 17.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TitleText(
                          text: fecha == '' ? 'Fecha' : fecha,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 17.0,
                        ),
                      ),
                      TitleText(
                        text: codigo == '' ? 'Código' : codigo,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 17.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60.0),
                        child: TitleText(
                          text: args.toString(),
                          color: Theme.of(context).colorScheme.secondary,
                          size: 17.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog(String mensajeEstado) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(mensajeEstado),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );

  Widget _inputNombre() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: _nombreController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 17.0),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Nombre del titular',
          labelText: 'Nombre del titular',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (nombreInput) {
          setState(() {
            nombre = nombreInput;
          });
        },
        onSaved: (val) => nombre = val!,
        validator: (nombreInput) {
          if (nombreInput!.isEmpty) {
            return 'Por favor ingresa un nombre';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputCard() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: _cardController,
        inputFormatters: [cardMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 17.0),
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: '0000-0000-0000-0000',
          labelText: 'Número de tarjeta',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (cardInput) {
          setState(() {
            card = cardInput;
          });
        },
        onSaved: (val) => nombre = val!,
        validator: (cardInput) {
          if (cardInput!.isEmpty) {
            return 'Por favor ingresa un numero';
          } else if (cardInput.contains('-')) {
            return 'Por favor no ingrese un -';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputDate() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: _fechaController,
        inputFormatters: [dateMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 17.0),
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'MM/YYYY',
          labelText: 'Fecha de vencimiento',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (dateInput) {
          setState(() {
            fecha = dateInput;
          });
        },
        onSaved: (val) => nombre = val!,
        validator: (dateInput) {
          if (dateInput!.isEmpty) {
            return 'Por favor ingresa una fecha';
          } else if (dateInput.contains('-')) {
            return 'Por favor no ingrese un -';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputCode() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: _codigoController,
        inputFormatters: [codeMask],
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 17.0),
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: '***',
          labelText: 'Codigo de verificación',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onChanged: (codeInput) {
          setState(() {
            codigo = codeInput;
          });
        },
        onSaved: (val) => nombre = val!,
        validator: (codeInput) {
          if (codeInput!.isEmpty) {
            return 'Por favor ingresa un código';
          } else if (codeInput.contains('-')) {
            return 'Por favor no ingrese un -';
          }
          return null;
        },
      ),
    );
  }

  Widget _inputSaldo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: _saldoController,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 18.0),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Saldo',
          labelText: 'Saldo',
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        validator: (saldoInput) {
          if (saldoInput!.isEmpty) {
            return 'Por favor ingresa un saldo';
          }
          return null;
        },
      ),
    );
  }
}
