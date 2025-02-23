import 'package:blogs_app/core/theme/app_pallet.dart';
import 'package:blogs_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_app/features/auth/presentation/pages/login_page.dart';
import 'package:blogs_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogs_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // Initialize the controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up.",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthField(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: "Password",
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthGradientButton(
                btnText: "Sign Up",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthSignUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        ));
                  }
                },
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    LoginPage.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          letterSpacing: 1,
                        ),
                    children: [
                      TextSpan(
                          text: 'Sign In',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
