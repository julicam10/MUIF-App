import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';
import '../models/bar_code_text.dart';

class MonederoVirtualPage extends StatefulWidget {
  const MonederoVirtualPage({Key? key}) : super(key: key);

  @override
  State<MonederoVirtualPage> createState() => _MonederoVirtualPageState();
}

String description = "Movilidad Urbana | Inteligente en Fusagasugá";

String newDescription = description.replaceAll("|", "\n");

class _MonederoVirtualPageState extends State<MonederoVirtualPage> {
  User? user = FirebaseAuth.instance.currentUser;
  String monto = '0';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BarCodeText;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading:
            BackArrowButton(color: Theme.of(context).colorScheme.secondary),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/barCode'),
              icon: Icon(
                Icons.qr_code,
                color: Theme.of(context).colorScheme.secondary,
                size: 40.0,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const TitleText(
              text: 'Monedero Digital MUIF',
              color: Colors.black,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 180,
                width: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    const SizedBox(
                      height: 700,
                      width: 700,
                      child: Image(
                        image: AssetImage('assets/img/fondoTarjetAMuif.jpeg'),
                        fit: BoxFit.cover,
                        height: 500,
                        color: Color.fromRGBO(255, 255, 255, 0.1),
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: SizedBox(
                                  height: 80.0,
                                  width: 200.0,
                                  child: TitleText(
                                    text:
                                        'Movilidad Urbana Inteligente en Fusagasugá',
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 45.0),
                                child: Container(
                                  height: 65.0,
                                  width: 65.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/img/iconFlutter.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .collection('monedero')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                if (!streamSnapshot.hasData) {
                                  return Center(child: Text('Saldo: \$$monto'));
                                } else {
                                  return ListView.builder(
                                    itemCount: streamSnapshot.data?.docs.length,
                                    itemBuilder: (ctx, index) => TitleText(
                                      text:
                                          'Saldo: \$${streamSnapshot.data!.docs[index]['saldo'].toString()}',
                                      color: Colors.black,
                                      size: 15.0,
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: TitleText(
                text: 'Historial de pagos',
                color: Colors.black,
                size: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 350,
                width: 300,
                child: streamWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
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
                                '/autorizacion',
                              ),
                        text: 'Recargar saldo monedero MUIF',
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
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 50,
                width: 270,
                child: Hero(
                  tag: 'boton',
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: args.barCodeText.length == 1
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                      primary: args.barCodeText.length == 1
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary,
                      textStyle: GoogleFonts.nunito(
                        fontSize: args.barCodeText.length == 1 ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: args.barCodeText.length == 1
                        ? const Text('Primero escanea un QR')
                        : const Text('Continuar'),
                    onPressed: () {
                      args.barCodeText.length == 1
                          ? null
                          : Navigator.pushNamed(
                              context, '/seleccionarInformacion');
                    },
                  ),
                ),
              ),
            ),
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
          .collection('historial')
          .orderBy('fecha', descending: true)
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
                  text: 'Fecha: ${streamSnapshot.data?.docs[index]['fecha']}',
                  color: Colors.black,
                  size: 16.0,
                ),
                subtitle: TitleText(
                  text:
                      'Cantidad de pasajes: ${streamSnapshot.data?.docs[index]['cantidadPasajes'].toString()}',
                  color: Colors.black,
                  size: 15.0,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TitleText(
                      text: 'Total:',
                      color: Colors.white,
                      size: 15.0,
                    ),
                    TitleText(
                      text:
                          '\$ ${streamSnapshot.data!.docs[index]['total'].toString()}',
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
