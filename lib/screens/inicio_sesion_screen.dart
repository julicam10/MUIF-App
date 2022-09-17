// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);
  static const String routeName = 'Iniciar_Sesion';

  @override
  State<InicioSesionPage> createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  String email = '';
  String password = '';
  bool selectedValue = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future _iniciarSesion(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      _navegar(context);
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error en la información ingresada'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  _navegar(context) {
    Navigator.pushNamed(context, '/eleccionRol');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.002
                        : size.height * 0.006,
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 327,
                      width: 327,
                      child: ClipRRect(
                        // ignore: sort_child_properties_last
                        child: Image.asset('assets/img/iniciosesion.png'),
                        borderRadius: BorderRadius.circular(215),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.002
                        : size.height * 0.006,
                  ),
                  child: Text(
                    'Iniciar Sesión',
                    style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.003
                        : size.height * 0.005,
                  ),
                  child: SizedBox(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 30, top: 25),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.alternate_email_outlined,
                                ),
                                hintText: 'correo@ejemplo.com',
                                labelText: 'Correo electrónico',
                                suffixIconColor: Colors.white,
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              onSaved: (val) => email = val!,
                              validator: (val) {
                                if (!val!.contains('@') || !val.contains('.')) {
                                  return 'Por favor ingresa un correo valido';
                                } else {
                                  return null;
                                }
                              },
                              // onChanged: (value) => print(value), Verificación de entrada de texto
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 30,
                              top: size.height < 800
                                  ? size.height * 0.02
                                  : size.height * 0.03,
                            ),
                            child: TextFormField(
                              obscureText: selectedValue,
                              controller: passwordController,
                              validator: (passwordOne) {
                                if (passwordOne!.isEmpty) {
                                  return 'Por favor ingresa tu contraseña';
                                }
                                return null;
                              },
                              onSaved: (passwordOne) {
                                passwordOne = passwordOne!;
                                print(passwordOne);
                              },
                              decoration: InputDecoration(
                                icon: const Icon(Icons.lock),
                                hintText: 'Contraseña',
                                labelText: 'Contraseña',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    selectedValue
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    semanticLabel: selectedValue
                                        ? 'Contraseña oculta'
                                        : 'Contraseña visible',
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
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.03
                        : size.height * 0.03,
                    left: size.width * 0.5,
                  ),
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
                                context, '/recuperarContrasena'),
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
                  padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.03
                          : size.height * 0.05),
                  child: Center(
                    child: Hero(
                      tag: 'boton',
                      child: Center(
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
                            child: const Text('Iniciar sesión'),
                            onPressed: () {
                              _iniciarSesion(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height < 800
                          ? size.height * 0.03
                          : size.height * 0.03),
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
                                    '/registro',
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
