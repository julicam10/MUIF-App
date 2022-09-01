import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class TusTarjetasPage extends StatefulWidget {
  const TusTarjetasPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TusTarjetasPage> createState() => _TusTarjetasPageState();
}

class _TusTarjetasPageState extends State<TusTarjetasPage> {
  Map<String, dynamic>? data;
  String id = '';
  @override
  void initState() {
    super.initState();
  }

  CollectionReference tarjeta =
      FirebaseFirestore.instance.collection('correo@correo.com');
  Future<void> borrarTarjeta() {
    return tarjeta
        .doc(const Uuid().v1())
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

// BORRAR TODAS LAS TARJETAS
//   Future<void> batchDelete() {
//     CollectionReference tarjeta =
//         FirebaseFirestore.instance.collection('correo@correo.com');
//     WriteBatch batch = FirebaseFirestore.instance.batch();

//     return tarjeta.get().then((querySnapshot) {
//       for (var document in querySnapshot.docs) {
//         batch.delete(document.reference);
//       }

//       return batch.commit();
//     });
//   }

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
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('correo@correo.com')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                          onLongPress: () {
                            openDialog();
                          },
                        ),
                      ),
                    );
                  },
                ),
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
      ),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                borrarTarjeta();
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
}
