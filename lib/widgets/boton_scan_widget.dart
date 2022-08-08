import 'package:muif_app/models/utilities.dart';

class ScanBoton extends StatelessWidget {
  const ScanBoton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            'x0E2045', 'Cancelar', false, ScanMode.QR);
      },
    );
  }
}
