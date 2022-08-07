import 'package:flutter/material.dart';
import 'package:muif_app/models/utilities.dart';

class NormalText extends StatelessWidget {
  const NormalText({
    Key? key,
    required this.text,
    required this.color,
    required this.size,
  }) : super(key: key);
  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sourceSerifPro(
        fontSize: size,
        color: color,
      ),
    );
  }
}
