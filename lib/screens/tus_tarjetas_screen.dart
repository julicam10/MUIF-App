// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

class TusTarjetasPage extends StatefulWidget {
  const TusTarjetasPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TusTarjetasPage> createState() => _TusTarjetasPageState();
}

class _TusTarjetasPageState extends State<TusTarjetasPage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? data;
  List<String> docIDS = [];
  int indexBorrar = 0;
  String id = '';

  CollectionReference instanciaUsers =
      FirebaseFirestore.instance.collection('users');

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
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDS.add(document.reference.id);
              print('DocsID: $docIDS');
            },
          ),
        );
  }

  Future<void> borrarTarjeta() {
    print('Document id String: ${docIDS.toString()}');
    return instanciaUsers
        .doc(user!.uid)
        .collection('tarjetas')
        .doc(
          docIDS[indexBorrar],
        )
        .delete()
        .then((value) => print("Tarjeta borrada"))
        .catchError((error) => print("Error al borrar la tarjeta: $error"));
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
          const Center(
            child: TitleText(
              text: 'Tus tarjetas registradas',
              color: Colors.black,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 650,
              width: 350,
              child: streamWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: '',
                  style: GoogleFonts.sourceSerifPro(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(
                              context,
                              '/registrarTarjeta',
                            ),
                      text: ' Registar nueva tarjeta',
                      style: GoogleFonts.sourceSerifPro(
                        color: const Color(0xFF3D73DD),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
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
                  indexBorrar = index;
                  print('index: $index');
                  print('indexBorrar: $indexBorrar');
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
          title: const Text('¿Desea eleminar está tarjeta?'),
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
                borrarTarjeta();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
