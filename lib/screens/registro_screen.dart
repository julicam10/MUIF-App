// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

import '../main.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);
  static const String routeName = 'Registrarse';

  @override
  State<RegistroPage> createState() => RegistroPageState();
}

class RegistroPageState extends State<RegistroPage> {
  String email = '';
  String passwordOne = '';
  String passwordTwo = '';
  bool selectedValue = true;
  bool selectedValueTwo = true;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordOneController = TextEditingController();
  final _passwordTwoController = TextEditingController();

  Future _registrarUsuario(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordTwoController.text.trim(),
          )
          .then((value) => {
                _postDetailsToFirestore(email, 'pasajero'),
                _crearMonedero(),
              })
          .catchError((e) {});
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error, verifique los datos e intente de nuevo'),
          backgroundColor: Colors.red,
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  _postDetailsToFirestore(String email, String rol) async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore instanciaFirebase = FirebaseFirestore.instance;
    await instanciaFirebase.collection('users').doc(user?.uid).set({
      'correo': _emailController.text.trim(),
      'id': user?.uid,
      'rol': rol,
    });
  }

  Future<void> _crearMonedero() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('monedero')
        .doc('unico')
        .set({
          'saldo': 0,
        })
        .then((value) => print("Monedero creado"))
        .catchError((error) => print("Error al crear el monedero: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading: BackArrowButton(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  child: TitleText(
                      text: 'MUIF APP',
                      size: 30,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.02
                        : size.height * 0.04,
                  ),
                  child: const NormalText(
                    text: 'Movilidad Urbana Inteligente en Fusagasugá.',
                    color: Colors.black,
                    size: 22,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height < 800
                        ? size.height * 0.04
                        : size.height * 0.05,
                  ),
                  child: TitleText(
                    text: 'Crea tu cuenta',
                    size: 35,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height < 800
                                ? size.height * 0.02
                                : size.height * 0.035,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 30, top: 25),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                icon:
                                    const Icon(Icons.alternate_email_outlined),
                                hintText: 'correo@ejemplo.com',
                                labelText: 'Correo electrónico',
                                suffixIconColor: Colors.white,
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade600),
                              ),
                              onSaved: (val) => email = val!,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (!val!.contains('@') || !val.contains('.')) {
                                  return 'Correo invalido';
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
                            left: 15,
                            right: 30,
                            top: size.height < 800
                                ? size.height * 0.015
                                : size.height * 0.02,
                          ),
                          child: TextFormField(
                            obscureText: selectedValue,
                            controller: _passwordOneController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (passwordOne) {
                              if (passwordOne!.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              }
                              if (passwordOne.length < 6) {
                                return 'Tu contraseña debe tener como mínimo 6 caracteres';
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 30,
                            top: size.height < 800
                                ? size.height * 0.015
                                : size.height * 0.02,
                          ),
                          child: TextFormField(
                            obscureText: selectedValueTwo,
                            controller: _passwordTwoController,
                            style: GoogleFonts.openSans(),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (passwordTwo) {
                              if (passwordTwo!.isEmpty) {
                                return 'Por favor ingresa una contraseña';
                              }
                              if (passwordTwo.length < 6) {
                                return 'Tu contraseña debe tener como mínimo 6 caracteres';
                              }
                              if (_passwordTwoController.text !=
                                  _passwordOneController.text) {
                                return 'Las contraseñas no coinciden';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (passwordTwo) {
                              passwordTwo = passwordTwo!;
                              print(passwordTwo);
                            },
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              hintText: 'Confirmar contraseña',
                              labelText: 'Confirmar contraseña',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  selectedValueTwo
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  semanticLabel: selectedValueTwo
                                      ? 'Contraseña oculta'
                                      : 'Contraseña visible',
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedValueTwo ^= true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height < 800
                                ? size.height * 0.6
                                : size.height * 0.10,
                          ),
                          child: Hero(
                            tag: 'boton',
                            child: Center(
                              child: SizedBox(
                                height: 50,
                                width: 270,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    onPrimary:
                                        Theme.of(context).colorScheme.primary,
                                    primary:
                                        Theme.of(context).colorScheme.secondary,
                                    textStyle: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Iniciar sesión'),
                                  onPressed: () {
                                    _registrarUsuario(context);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
