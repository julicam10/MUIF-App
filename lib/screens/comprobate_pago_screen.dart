import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:muif_app/widgets/widgets.dart';
import '../models/utilities.dart';

class ComprobantePagoPage extends StatefulWidget {
  const ComprobantePagoPage({Key? key}) : super(key: key);
  static const routeName = '/comprobantePago';
  @override
  State<ComprobantePagoPage> createState() => _ComprobantePagoPageState();
}

User? user = FirebaseAuth.instance.currentUser;
final DateTime now = DateTime.now();
String fecha = DateFormat('yyyy-MM-dd – kk:mm').format(now);
int totalPagar = 0;

class _ComprobantePagoPageState extends State<ComprobantePagoPage> {
  @override
  Widget build(BuildContext context) {
    final info = ModalRoute.of(context)!.settings.arguments;
    int infoInt = int.parse(info.toString());
    totalPagar = infoInt * 1850;
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: TitleText(
                  text: 'Comprobante de pago',
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Container(
                  height: 490,
                  width: 330,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _rowBanner(),
                        const Divider(
                          color: Colors.black,
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              _rowRuta(),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: _rowPuntosRuta())
                            ],
                          ),
                        ),
                        _fecha(),
                        _correo(),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              const TitleText(
                                  text: 'Cantidad de pasajes',
                                  color: Colors.black,
                                  size: 20.0),
                              NormalText(
                                  text: info.toString(),
                                  color: Colors.black,
                                  size: 15.0)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              const TitleText(
                                  text: 'Total a pagar',
                                  color: Colors.black,
                                  size: 20.0),
                              NormalText(
                                  text: '\$ ${totalPagar.toString()}',
                                  color: Colors.black,
                                  size: 15.0)
                            ],
                          ),
                        ),
                        _saldo(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
          child: const Image(
            image: AssetImage('assets/img/iconFlutter.png'),
          ),
        ),
        Column(
          children: const [
            TitleText(text: 'MUIF APP', color: Colors.black, size: 20.0),
          ],
        ),
        const Icon(Icons.check_circle, color: Colors.green, size: 40.0),
      ],
    );
  }

  Widget _rowPuntosRuta() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Container(
            height: 20.0,
            width: 20.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        Container(
          width: 135.0,
          height: 1.0,
          color: Colors.black45,
        ),
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ],
    );
  }

  Widget _fecha() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleText(text: 'Fecha', color: Colors.black, size: 20.0),
          NormalText(
            text: fecha,
            color: Colors.black,
            size: 15.0,
          )
        ],
      ),
    );
  }

  Widget _correo() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(text: 'Correo', color: Colors.black, size: 20.0),
          NormalText(
              text: user!.email.toString(), color: Colors.black, size: 15.0)
        ],
      ),
    );
  }

  Widget _saldo() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          const TitleText(text: 'Tu saldo', color: Colors.black, size: 20.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 55.0,
            ),
            child: SizedBox(
              height: 30,
              width: 100,
              child: Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .collection('monedero')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (!streamSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: streamSnapshot.data?.docs.length,
                        itemBuilder: (ctx, index) => NormalText(
                          text:
                              '\$${streamSnapshot.data!.docs[index]['saldo'].toString()}',
                          color: Colors.black,
                          size: 15.0,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowRuta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        TitleText(text: 'La Pampa', color: Colors.black, size: 20.0),
        TitleText(text: 'Terminal', color: Colors.black, size: 20.0),
      ],
    );
  }
}
