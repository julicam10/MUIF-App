// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muif_app/screens/pasajero/comprobate_pago_screen.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/normal_text_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';
import 'package:uuid/uuid.dart';

class PagarPasajePage extends StatefulWidget {
  const PagarPasajePage(
      {Key? key,
      required this.cantidadPasajes,
      required this.totalAPagar,
      required this.numeroBuseta,
      required this.fecha})
      : super(key: key);
  final int cantidadPasajes;
  final int totalAPagar;
  final String numeroBuseta;
  final String fecha;

  @override
  State<PagarPasajePage> createState() => _PagarPasajePageState();
}

final DateTime now = DateTime.now();

class _PagarPasajePageState extends State<PagarPasajePage> {
  final String historialId = const Uuid().v1();
  User? user = FirebaseAuth.instance.currentUser;
  bool _estaActivo = false;
  int cantidad = 0;
  int saldo = 0;
  int totalAPagar = 0;

  @override
  void initState() {
    super.initState();
  }

  CollectionReference instanciaUser =
      FirebaseFirestore.instance.collection('users');

  CollectionReference instanciaRoute =
      FirebaseFirestore.instance.collection('route');

  Future<void> _getAndUpdateSaldo() {
    cantidad = int.parse(widget.cantidadPasajes.toString());
    final sfDocRef =
        instanciaUser.doc(user!.uid).collection('monedero').doc('unico');
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(sfDocRef);
      saldo = snapshot.get("saldo");
      totalAPagar = int.parse(widget.totalAPagar.toString());
      if (totalAPagar > saldo) {
        saldoInsuficienteDialog();
        return;
      } else {
        final int nuevoSaldo = saldo - totalAPagar;
        transaction.update(sfDocRef, {"saldo": nuevoSaldo});
        _insertarRegistroHistorial();
        _insertarPagoConductor();
        _navegar();
      }
    });
  }

  void _navegar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ComprobantePagoPage(
          codigoBuseta: widget.numeroBuseta.toString(),
          cantidad: cantidad,
        ),
      ),
    );
  }

  Future<void> _insertarRegistroHistorial() {
    return instanciaUser
        .doc(user!.uid)
        .collection('historial')
        .doc(historialId)
        .set({
          'cantidadPasajes': cantidad,
          'fecha': widget.fecha,
          'total': totalAPagar,
        })
        .then((value) => print("Pago cargado al conductor"))
        .catchError(
            (error) => print("Error al cargar el pago al coductor: $error"));
  }

  Future<void> _insertarPagoConductor() {
    return instanciaRoute
        .doc('001')
        .collection('people')
        .doc(widget.numeroBuseta.toString())
        .collection('pagos')
        .doc(historialId)
        .set({
          'fecha': widget.fecha.toString(),
          'estado': 'Aprobado',
          'numeroPasajes': cantidad,
          'total': totalAPagar,
        })
        .then((value) => print("Agregado al historial"))
        .catchError((error) => print("Error al agregar al historial: $error"));
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: TitleText(
                text: 'Revisa que todo este correcto',
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: TitleText(
                text: '\$ ${widget.totalAPagar} COP',
                color: Colors.black,
                size: 25.0,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: Row(
              children: [
                const NormalText(
                  text: 'Cantidad de pasajes: ',
                  color: Colors.grey,
                  size: 20.0,
                ),
                NormalText(
                  text: widget.cantidadPasajes.toString(),
                  color: Colors.black,
                  size: 20.0,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Center(
              child: TitleText(
                text: 'Método de pago',
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, left: 20.0, right: 20.0, bottom: 30.0),
            child: Row(
              children: const [
                NormalText(
                    text: 'Monedero MUIF APP ', color: Colors.grey, size: 18.0),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CheckboxListTile(
                      checkColor: Theme.of(context).colorScheme.primary,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      title: const NormalText(
                        text: 'Estoy de acuerdo en realizar el pago',
                        color: Colors.white,
                        size: 20.0,
                      ),
                      value: _estaActivo,
                      onChanged: (value) => setState(() {
                        _estaActivo = value ?? true;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 300.0),
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
                            text: 'Pagar',
                            color: Theme.of(context).colorScheme.primary,
                            size: 20.0,
                          ),
                          onPressed: () {
                            if (_estaActivo == true) {
                              _getAndUpdateSaldo();
                            } else {
                              _comprobanteDialog();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _comprobanteDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
              const Text('Primero debes estar de acuerdo con la transferencia'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );

  Future saldoInsuficienteDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
              'No cuentas con suficiente saldo en tu monedero MUIF para realizar la transacción'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
