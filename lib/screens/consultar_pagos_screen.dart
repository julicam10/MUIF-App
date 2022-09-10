import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:muif_app/widgets/title_widget.dart';

class ConsultarPagosPage extends StatefulWidget {
  const ConsultarPagosPage({Key? key}) : super(key: key);

  @override
  State<ConsultarPagosPage> createState() => _ConsultarPagosPageState();
}

class _ConsultarPagosPageState extends State<ConsultarPagosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TitleText(
          text: 'Historial de pagos',
          color: Theme.of(context).colorScheme.secondary,
          size: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: streamWidget(),
      ),
    );
  }

  Widget streamWidget() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('route')
          .doc('001')
          .collection('pagos')
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
                  text: 'Estado: ${streamSnapshot.data?.docs[index]['estado']}',
                  color: Colors.black,
                  size: 16.0,
                ),
                subtitle: TitleText(
                  text: 'Fecha: ${streamSnapshot.data?.docs[index]['fecha']}',
                  color: Colors.black,
                  size: 15.0,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      text:
                          'Pasajes: ${streamSnapshot.data!.docs[index]['numeroPasajes'].toString()}',
                      color: Colors.white,
                      size: 15.0,
                    ),
                    TitleText(
                      text:
                          'total: \$${streamSnapshot.data!.docs[index]['total'].toString()}',
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
