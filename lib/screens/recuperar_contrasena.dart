import 'package:flutter/material.dart';

import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

class RecuperarContrasenaPage extends StatefulWidget {
  const RecuperarContrasenaPage({Key? key}) : super(key: key);
  static const String routeName = 'Recuperar_Contraseña';

  @override
  State<RecuperarContrasenaPage> createState() =>
      _RecuperarContrasenaPageState();
}

class _RecuperarContrasenaPageState extends State<RecuperarContrasenaPage> {
  String email = '';
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.background,
            size: 40.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Text(
                  'MUIF APP',
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Text(
                  'Recupera tu contraseña',
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Text(
                  'Ingresa el correo electrónico con el que te registraste, para poder recuperar tu contraseña.',
                  style: GoogleFonts.sourceSerifPro(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: EmailWidget(
                  emailController: emailController,
                  colorHint: Colors.white,
                  colorLabel: Colors.white,
                  colorIcon: Colors.white,
                  colorCursor: Colors.white,
                  textStyle: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 30, top: 210),
                child: Center(
                  child: Hero(
                    tag: 'boton',
                    child: BotonWidget(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.primary,
                      text: 'Enviar correo',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
