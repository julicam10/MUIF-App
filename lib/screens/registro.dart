import 'package:flutter/material.dart';

import 'package:muif_app/models/utilities.dart';
import 'package:muif_app/widgets/widgets.dart';

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
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          leading: BackArrowButton(
            color: Theme.of(context).colorScheme.secondary,
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: height < 800 ? height * 0.002 : height * 0.006,
                ),
                child: TitleText(
                    text: 'MUIF APP',
                    size: 30,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height < 800 ? height * 0.02 : height * 0.04,
                ),
                child: const NormalText(
                  text: 'Movilidad Urbana Inteligente en Fusagasugá.',
                  color: Colors.black,
                  size: 22,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height < 800 ? height * 0.04 : height * 0.05,
                ),
                child: TitleText(
                  text: 'Crea tu cuenta',
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height < 800 ? height * 0.02 : height * 0.035,
                ),
                child: EmailWidget(
                  emailController: emailController,
                  colorHint: Theme.of(context).colorScheme.onSecondary,
                  colorLabel: Colors.grey.shade600,
                  colorIcon: Theme.of(context).colorScheme.onSecondary,
                  colorCursor: Colors.grey.shade600,
                  textStyle: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 30,
                  top: height < 800 ? height * 0.015 : height * 0.02,
                ),
                child: TextFormField(
                  obscureText: selectedValue,
                  controller: passwordOneController,
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
                        selectedValue ? Icons.visibility : Icons.visibility_off,
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
                  top: height < 800 ? height * 0.015 : height * 0.02,
                ),
                child: TextFormField(
                  obscureText: selectedValueTwo,
                  controller: passwordTwoController,
                  style: GoogleFonts.openSans(),
                  validator: (passwordTwo) {
                    if (passwordTwo!.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    if (passwordTwoController.text !=
                        passwordOneController.text) {
                      return 'Las contraseñas no son la misma';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (passwordTwo) {
                    passwordTwo = passwordTwo!;
                    print(passwordTwo);
                  },
                  // onChanged: (passwordTwo) {
                  //   setState(() {
                  //     _enteredText2 = passwordTwo;
                  //   });
                  // },
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
                  top: height < 800 ? height * 0.12 : height * 0.09,
                ),
                child: Hero(
                  tag: 'boton',
                  child: Center(
                    child: BotonWidget(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      text: 'Continuar',
                      textColor: Theme.of(context).colorScheme.primary,
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
