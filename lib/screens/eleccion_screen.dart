import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/utilities.dart';
import '../widgets/widgets.dart';

class EleccionPage extends StatefulWidget {
  const EleccionPage({Key? key}) : super(key: key);

  @override
  State<EleccionPage> createState() => _EleccionPageState();
}

class _EleccionPageState extends State<EleccionPage> {
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('correo@correo.com')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                                text: streamSnapshot.data?.docs[index]
                                    ['nombre'],
                                color: Colors.black,
                                size: 16.0,
                              ),
                              subtitle: TitleText(
                                text: streamSnapshot.data?.docs[index]
                                    ['numero'],
                                color: Colors.black,
                                size: 15.0,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TitleText(
                                    text: streamSnapshot.data!.docs[index]
                                        ['tipo'],
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
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    height: 65,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: TitleText(
                        color: Theme.of(context).colorScheme.primary,
                        size: 20.0,
                        text: 'Lista de tarjetas del usuario',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
