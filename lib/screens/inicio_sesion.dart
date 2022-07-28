import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:muif_app/screens/screens.dart';
import 'package:muif_app/widgets/widgets.dart';

import 'package:muif_app/models/utilities.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);
  static const String routeName = 'Iniciar_Sesion';

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

String email = '';
String password = '';
bool selectedValue = true;

class _InicioSesionPageState extends State<InicioSesionPage> {
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
                  colorHint: Theme.of(context).colorScheme.onSecondary,
                  colorLabel: Colors.grey.shade600,
                  colorIcon: Theme.of(context).colorScheme.onSecondary,
                  colorCursor: Colors.grey.shade600,
                  textStyle: Theme.of(context).colorScheme.onSecondary,
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
                            ..onTap = () => Navigator.pushNamed(
                                  context,
                                  RecuperarContrasenaPage.routeName,
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
                    child: Hero(
                      tag: 'boton',
                      child: BotonWidget(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.primary,
                        text: 'Iniciar sesión',
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
                              ..onTap = () => Navigator.pushNamed(
                                    context,
                                    RegistroPage.routeName,
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
