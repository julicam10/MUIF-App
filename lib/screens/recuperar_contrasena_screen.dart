// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:muif_app/widgets/widgets.dart';

import '../models/utilities.dart';

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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future _restablecerContrasena() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Correo enviado'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrio un error, intente nuevamente'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          elevation: 0.0,
          leading:
              BackArrowButton(color: Theme.of(context).colorScheme.background),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width < 390 ? size.width * 0.05 : size.width * 0.075,
                right:
                    size.width < 390 ? size.width * 0.05 : size.width * 0.075),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.02
                          : size.height * 0.04,
                    ),
                    child: const TitleText(
                      text: 'MUIF APP',
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.04
                          : size.height * 0.04,
                    ),
                    child: TitleText(
                      text: 'Recupera tu contraseña',
                      color: Theme.of(context).colorScheme.secondary,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.04
                          : size.height * 0.04,
                    ),
                    child: NormalText(
                      text:
                          'Ingresa el correo electrónico con el que te registraste, para poder recuperar tu contraseña.',
                      size: 18,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.06
                          : size.height * 0.06,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 30, top: 25),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.alternate_email_outlined,
                              color: Colors.white),
                          hintText: 'correo@ejemplo.com',
                          labelText: 'Correo electrónico',
                          suffixIconColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onSaved: (val) => email = val!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (!val!.contains('@') || !val.contains('.')) {
                            return 'Invalid Email';
                          } else {
                            return null;
                          }
                        },
                        // onChanged: (value) => print(value), Verificación de entrada de texto
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.2
                          : size.height * 0.27,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Hero(
                        tag: 'boton',
                        child: SizedBox(
                          height: 50,
                          width: 270,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Theme.of(context).colorScheme.primary,
                              primary: Theme.of(context).colorScheme.secondary,
                              textStyle: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Recuperar contraseña'),
                            onPressed: () {
                              _restablecerContrasena();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
