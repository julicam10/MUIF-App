// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muif_app/screens/screens_screen.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

import '../../models/bar_code_text.dart';

class EleccionPage extends StatefulWidget {
  const EleccionPage({Key? key, required this.valor}) : super(key: key);

  final int valor;

  @override
  State<EleccionPage> createState() => _EleccionPageState();
}

class _EleccionPageState extends State<EleccionPage> {
  int indexActualizar = 0;
  String barcodeScanRes = '0';
  CollectionReference instanciaUser =
      FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  List<String> docIDS = [];

  @override
  void initState() {
    super.initState();
    getDocId();
  }

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('tarjetas')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDS.add(document.reference.id);
              print('DocsID: $docIDS');
            },
          ),
        );
  }

  Future<void> _getAndUpdateSaldoTarjeta() {
    final sfDocRef = instanciaUser
        .doc(user!.uid)
        .collection('tarjetas')
        .doc(docIDS[indexActualizar]);
    print('valor: $valor');
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(sfDocRef);
      final int saldo = snapshot.get("saldo");
      print('saldo: $saldo');
      if (valor > saldo) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'El valor ingresado es mayor al que tienes disponible en tu tarjeta'),
            backgroundColor: Colors.red,
          ),
        );
        print('El saldo de la tarjeta no puede ser mayor al valor ingresado');
        return;
      }
      if (valor < saldo) {
        final int nuevoSaldo = saldo - valor;
        transaction.update(sfDocRef, {"saldo": nuevoSaldo});
        _getAndUpdateSaldoMonedero();
      }
    }).then(
      (value) => print("Saldo de tarjeta actualizado correctamente"),
      onError: (e) => print("No se pudo actualizar el saldo, error: $e"),
    );
  }

  Future<void> _getAndUpdateSaldoMonedero() {
    final sfDocRef =
        instanciaUser.doc(user!.uid).collection('monedero').doc('unico');
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(sfDocRef);
      final saldo = snapshot.get("saldo");
      final nuevoSaldo = saldo + valor;
      transaction.update(sfDocRef, {"saldo": nuevoSaldo});
    }).then(
      (value) =>
          {print("Saldo de monedero actualizado correctamente"), _navegar()},
      onError: (e) => print("No se pudo actualizar el saldo $e"),
    );
  }

  void _navegar() {
    Navigator.pushNamed(
      context,
      '/monederoVirtual',
      arguments: BarCodeText(barcodeScanRes),
    );
  }

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
        child: ListView(
          children: [
            Column(
              children: [
                const Center(
                  child: TitleText(
                    text: '¿De donde saldrá el dinero?',
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: 550,
                    width: 350,
                    child: streamWidget(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget streamWidget() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('tarjetas')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (!streamSnapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder: (ctx, index) => Container(
              height: 75.0,
              width: 50.0,
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(82, 150, 250, 0.2),
                    Color.fromRGBO(0, 98, 189, 1),
                  ],
                  stops: [0.1, 0.9],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
              ),
              child: ListTile(
                title: TitleText(
                  text: streamSnapshot.data?.docs[index]['nombre'],
                  color: Colors.black,
                  size: 16.0,
                ),
                subtitle: TitleText(
                  text: streamSnapshot.data?.docs[index]['numero'],
                  color: Colors.black,
                  size: 15.0,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text: streamSnapshot.data!.docs[index]['tipo'],
                      color: Colors.white,
                      size: 15.0,
                    ),
                    TitleText(
                      text:
                          'Saldo: \$${streamSnapshot.data!.docs[index]['saldo'].toString()}',
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ],
                ),
                onTap: () {
                  indexActualizar = index;
                  openDialog();
                },
              ),
            ),
          );
        }
      },
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Desea descontar el monto de esta tarjeta?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // _getAndUpdateSaldoMonedero();
                _getAndUpdateSaldoTarjeta();
              },
            )
          ],
        ),
      );
}
