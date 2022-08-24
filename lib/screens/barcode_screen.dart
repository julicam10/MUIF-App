import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

import '../models/bar_code_text.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String _scanBarcode = 'Sin  dirección de la buseta';

  Future<void> scanQR() async {
    String barcodeScanRes = '2562';
    try {
      // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //     '#ff6666', 'Cancel', true, ScanMode.QR);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        '/monederoVirtual',
        arguments: BarCodeText(barcodeScanRes),
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () => scanQR(),
          child: const Icon(Icons.filter_center_focus),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/monederoVirtual'),
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black,
              ),
            ),
            const TitleText(
                text: 'Número de la buseta', color: Colors.black, size: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Center(
                child: TitleText(
                    text: _scanBarcode, color: Colors.black, size: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
