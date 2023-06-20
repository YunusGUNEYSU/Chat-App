import 'package:flutter/material.dart';

import '../../core/validation/form_validation.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isObsecure;
  const MyTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.isObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
       return FormValitadion.emailPasswordValitadion(value!);
      },
      keyboardType: TextInputType.emailAddress,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: textEditingController,
      obscureText: isObsecure,
      decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade200))),
    );
  }
}
