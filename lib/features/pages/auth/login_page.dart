import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormFieldState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  height: 150,
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
                  height: 25,
                ),
                MyButton(
                  buttonText: "Sign in",
                  onPressed: () {
                    //Todo sign in method
                    context
                        .read<AuthProvider>()
                        .signInUser(_emailController.text, _passwordController.text);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    TextButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Register now",
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
