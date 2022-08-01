import 'package:flutter/material.dart';
import 'package:muif_app/models/utilities.dart';

class BotonWidget extends StatelessWidget {
  const BotonWidget({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.navigator,
  }) : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String navigator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 270,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: textColor,
          primary: backgroundColor,
          textStyle: GoogleFonts.sourceSerifPro(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text),
        onPressed: () => Navigator.pushNamed(context, navigator),
      ),
    );
  }
}
