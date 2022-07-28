import 'package:flutter/material.dart';
import 'package:muif_app/models/utilities.dart';

class BotonWidget extends StatelessWidget {
  const BotonWidget({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: () {},
      ),
    );
  }
}
