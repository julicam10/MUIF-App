// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muif_app/widgets/arrow_back_widget.dart';
import 'package:muif_app/widgets/title_widget.dart';

class RegistrarTarjetaPage extends StatefulWidget {
  const RegistrarTarjetaPage({Key? key}) : super(key: key);
  @override
  State<RegistrarTarjetaPage> createState() => _RegistrarTarjetaPageState();
}

String tipoTarjeta = '';
bool selectedCredito = false;
bool selectedDebito = false;

class _RegistrarTarjetaPageState extends State<RegistrarTarjetaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading:
            BackArrowButton(color: Theme.of(context).colorScheme.secondary),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleText(
              text: '¿Qué tipo de tarjeta quieres registrar?',
              color: Colors.black,
              size: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 320.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: selectedCredito == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            selectedCredito = true;
                            selectedDebito = false;
                          });
                          tipoTarjeta = 'Crédito';
                          print('Tipo tarjeta es: $tipoTarjeta');
                        },
                        icon: Icon(
                          Icons.credit_card,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 72,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TitleText(
                        text: 'Tarjeta de crédito',
                        color: Colors.black,
                        size: 17.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 320.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: selectedDebito == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 105,
                      height: 105,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            selectedCredito = false;
                            selectedDebito = true;
                          });
                          tipoTarjeta = 'Debito';
                          print('Tipo tarjeta es: $tipoTarjeta');
                        },
                        icon: Icon(
                          Icons.credit_score_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 72,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TitleText(
                        text: 'Tarjeta de debito',
                        color: Colors.black,
                        size: 17.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 280.0),
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
                    child: const Text('Continuar'),
                    onPressed: () {
                      print('Tipo tarjeta es: $tipoTarjeta');
                      if (tipoTarjeta.isNotEmpty) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/infoTarjeta',
                          arguments: tipoTarjeta,
                        );
                      } else {
                        seleccionTarjeta();
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future seleccionTarjeta() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Por favor selecciona un tipo de tarjeta'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
}
