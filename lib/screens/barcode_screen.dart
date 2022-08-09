import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String _scanBarcode = 'Sin  dirección de la buseta';

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      Navigator.pushNamed(context, '/tusTarjetas');
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => scanQR(),
          child: const Icon(Icons.filter_center_focus),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
