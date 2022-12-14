import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:muif_app/screens/pasajero/monedero_virtual_screen.dart';
import 'package:muif_app/widgets/title_widget.dart';

import '../../widgets/arrow_back_widget.dart';

class BarCodePage extends StatefulWidget {
  const BarCodePage({Key? key}) : super(key: key);

  @override
  State<BarCodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  String _scanBarcode = 'Sin  dirección de la buseta';

  Future<void> scanQR() async {
    String barcodeScanRes = '';
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      setState(() {
        _scanBarcode = barcodeScanRes;
        print('Valor esnaceado: $_scanBarcode');
      });
      navegar();
      // ignore: use_build_context_synchronously
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
  }

  navegar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MonederoVirtualPage(
          codigoBuseta: _scanBarcode,
        ),
      ),
    );
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
    );
  }
}
