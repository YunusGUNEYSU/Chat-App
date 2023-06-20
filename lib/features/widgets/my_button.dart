import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  const MyButton({super.key, required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.08,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
