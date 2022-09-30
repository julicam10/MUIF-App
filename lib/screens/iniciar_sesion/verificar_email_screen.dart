import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:muif_app/screens/screens_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

class VerificarEmailPage extends StatefulWidget {
  const VerificarEmailPage({Key? key}) : super(key: key);

  @override
  State<VerificarEmailPage> createState() => _VerificarEmailPageState();
}

class _VerificarEmailPageState extends State<VerificarEmailPage> {
  bool isEmailVerify = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerify) {
      _sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 5),
        (_) => _checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future _checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerify) timer?.cancel();
  }

  Future _sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerify
      ? const HomePage()
      : Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0.0,
            leading: BackArrowButton(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 200),
                child: SizedBox(
                  height: 200,
                  width: 350,
                  child: TitleText(
                    text:
                        'Hemos enviado un correo de verificación de tu cuenta, por favor revisa tu bandeja de entrada o en spam.',
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                        onPressed:
                            canResendEmail ? _sendVerificationEmail : null,
                        child: const Text('Reenviar correo'),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
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
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Cancelar'),
                  ),
                ),
              ),
            ],
          ),
        );
}
