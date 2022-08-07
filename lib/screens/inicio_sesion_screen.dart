// ignore_for_file: avoid_print

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
    print(height);
    print(width);
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
                    top: height < 800 ? height * 0.002 : height * 0.006,
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
                    top: height < 800 ? height * 0.002 : height * 0.006,
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
                    top: height < 800 ? height * 0.003 : height * 0.005,
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
                    top: height < 800 ? height * 0.02 : height * 0.03,
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
                Padding(
                  padding: EdgeInsets.only(
                    top: height < 800 ? height * 0.03 : height * 0.03,
                    left: width * 0.5,
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
                      top: height < 800 ? height * 0.03 : height * 0.05),
                  child: Center(
                    child: Hero(
                      tag: 'boton',
                      child: Center(
                        child: BotonWidget(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          textColor: Theme.of(context).colorScheme.primary,
                          text: 'Iniciar sesión',
                          navigator: '/home',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height < 800 ? height * 0.03 : height * 0.06),
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
