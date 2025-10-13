import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.inputTextStyleColor,
    this.readOnly = false,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? text;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final Color? inputTextStyleColor;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String?)? onFieldSubmitted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController controller;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.blue,
      controller: controller,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(color: widget.inputTextStyleColor ?? Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        labelText: widget.text,
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.all(20.0),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => obscureText = !obscureText);
                    },
                  )
                : null),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }
}
