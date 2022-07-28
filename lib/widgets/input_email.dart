import 'package:flutter/material.dart';
import 'package:muif_app/screens/screens.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    required this.emailController,
    required this.colorHint,
    required this.colorLabel,
    required this.colorIcon,
    required this.colorCursor,
    required this.textStyle,
  }) : super(key: key);

  final TextEditingController emailController;
  final Color colorHint;
  final Color colorLabel;
  final Color colorIcon;
  final Color colorCursor;
  final Color textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 30, top: 25),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        style: TextStyle(
          color: textStyle,
        ),
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email_outlined, color: colorIcon),
          hintText: 'correo@ejemplo.com',
          labelText: 'Correo electrónico',
          suffixIconColor: Colors.white,
          hintStyle: TextStyle(color: colorLabel),
          labelStyle: TextStyle(color: colorHint),
        ),
        onSaved: (val) => email = val!,
        validator: (val) {
          if (!val!.contains('@') || !val.contains('.')) {
            return 'Invalid Email';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
