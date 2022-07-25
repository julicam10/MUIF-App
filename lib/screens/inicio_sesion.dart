import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'recuperar_contrasena.dart';
import 'registro.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({Key? key}) : super(key: key);

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

String email = '';
String password = '';
bool selectedValue = true;

class _InicioSesionState extends State<InicioSesion> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 327,
                    width: 327,
                    child: ClipRRect(
                      // ignore: sort_child_properties_last
                      child: Image.asset('assets/img/iniciosesion.png'),
                      borderRadius: BorderRadius.circular(215),
                    ),
                  ),
                ),
                Text(
                  'Iniciar Sesión',
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                EmailWidget(
                  emailController: emailController,
                  colorHint: Colors.black,
                  colorLabel: Colors.black,
                  colorIcon: Colors.black,
                  colorCursor: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30, top: 25),
                  child: TextFormField(
                    obscureText: selectedValue,
                    controller: passwordController,
                    validator: (passwordOne) {
                      if (passwordOne!.isEmpty) {
                        return 'Please type something';
                      }
                      return null;
                    },
                    onSaved: (passwordOne) {
                      passwordOne = passwordOne!;
                      print(passwordOne);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Contraseña',
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                          selectedValue
                              ? Icons.visibility
                              : Icons.visibility_off,
                          semanticLabel:
                              selectedValue ? 'hide password' : 'show password',
                        ),
                        onPressed: () {
                          setState(() {
                            selectedValue ^= true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 170.0),
                  child: Text.rich(
                    TextSpan(
                      text: '',
                      style: GoogleFonts.sourceSerifPro(
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecuperarContrasenaPage(),
                                  ),
                                ),
                          text: 'Recuperar contraseña',
                          style: GoogleFonts.sourceSerifPro(
                            color: const Color(0xFF3D73DD),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30, top: 25),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 270,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Theme.of(context).colorScheme.primary,
                          primary: Theme.of(context).colorScheme.secondary,
                          textStyle: GoogleFonts.sourceSerifPro(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Iniciar sesión'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Si eres nuevo utilizando MUIF,',
                        style: GoogleFonts.sourceSerifPro(
                          color: const Color(0xFF8E8383),
                          fontSize: 18,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegistroPage(),
                                    ),
                                  ),
                            text: ' registrate',
                            style: GoogleFonts.sourceSerifPro(
                              color: const Color(0xFF3D73DD),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    required this.emailController,
    required this.colorHint,
    required this.colorLabel,
    required this.colorIcon,
    required this.colorCursor,
  }) : super(key: key);

  final TextEditingController emailController;
  final Color colorHint;
  final Color colorLabel;
  final Color colorIcon;
  final Color colorCursor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 30, top: 25),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusColor: Colors.white,
          icon: Icon(Icons.alternate_email_outlined, color: colorIcon),
          hintText: 'correo@ejemplo.com',
          labelText: 'Correo electrónico',
          suffixIconColor: Colors.white,
          hintStyle: TextStyle(color: colorLabel),
          labelStyle: TextStyle(color: colorHint),
        ),
        onSaved: (val) => email = val!,
        validator: (val) {
          if (!val!.contains('@') || !val.contains('.')) {
            return 'Invalid Email';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
