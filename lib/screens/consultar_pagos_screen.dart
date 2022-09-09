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
    );
  }
}
