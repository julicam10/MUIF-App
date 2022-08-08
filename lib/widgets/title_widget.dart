import 'package:muif_app/models/utilities.dart';

class TitleText extends StatelessWidget {
  const TitleText({
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
      style: GoogleFonts.nunito(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
