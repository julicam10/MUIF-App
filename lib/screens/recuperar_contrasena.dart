import 'package:flutter/material.dart';
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
        leading:
            BackArrowButton(color: Theme.of(context).colorScheme.background),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TitleText(
                    text: 'MUIF APP',
                    size: 35.0,
                    color: Colors.white,
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TitleText(
                      text: 'Recupera tu contraseña',
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30)),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: NormalText(
                  text:
                      'Ingresa el correo electrónico con el que te registraste, para poder recuperar tu contraseña.',
                  size: 18,
                  color: Theme.of(context).colorScheme.background,
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
                padding: const EdgeInsets.only(top: 195),
                child: Center(
                  child: Hero(
                    tag: 'boton',
                    child: Center(
                      child: BotonWidget(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.primary,
                        text: 'Enviar correo',
                      ),
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
