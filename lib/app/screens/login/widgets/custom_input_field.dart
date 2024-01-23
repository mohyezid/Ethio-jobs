import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

//custom input systetnd,fnfje
class CustomInputField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  TextEditingController txt;

  final bool show;

  CustomInputField({
    super.key,
    required this.txt,
    required this.label,
    required this.prefixIcon,
    this.show = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.txt,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
        ),
        hintText: widget.label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: widget.show
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kBlack.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: kBlack.withOpacity(0.5),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
