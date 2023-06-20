import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Icon(
                  Icons.message_outlined,
                  size: 100,
                  color: Colors.grey[800],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                    textEditingController: _emailController,
                    hintText: "Enter your email",
                    isObsecure: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                    textEditingController: _passwordController,
                    hintText: "Enter your password",
                    isObsecure: true),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                    textEditingController: _confirmPasswordController,
                    hintText: "Confirm your password",
                    isObsecure: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  buttonText: "Sign up",
                  onPressed: () async {
                    //Todo sign up method
                    if (_passwordController.text == _confirmPasswordController.text &&
                        formKey.currentState!.validate()) {
                      await context
                          .read<AuthProvider>()
                          .createUser(_emailController.text, _passwordController.text);
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?"),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
