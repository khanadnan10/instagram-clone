import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    const outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 88, 88, 88),
        width: 1.0,
      ),
    );

    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: outlineBorder,
        hintText: hintText,
        focusedBorder: outlineBorder,
        filled: true,
        fillColor: mobileSearchColor,
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
