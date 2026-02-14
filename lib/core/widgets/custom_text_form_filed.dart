import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextEditingController? controller;
  final String hintText;
  const CustomTextFormFiled({
    super.key,
    this.controller,
    required this.hintText,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
        ),
      ),
    );
  }
}
