// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/pages/home_screen.dart';
import 'package:instagram_clone/pages/signup_screen.dart';
import 'package:instagram_clone/database/auth_method.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobileLayout.dart';
import '../responsive/webLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isloading = false;

  void login() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    if (res == 'success') {
      // navigate to home screen
      nextPageReplacement(
        context,
        const ResponsiveLayout(
          MobileLayout: MobileLayout(),
          WebLayout: WebLayout(),
        ),
      );
      print('logged in successfully');
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                height: 64,
                color: Colors.white,
              ),
              const SizedBox(height: 35.0),
              TextFieldInput(
                hintText: 'Email',
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFieldInput(
                hintText: 'Password',
                textEditingController: _passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Forget password firebase implementation
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () => login(),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  child: _isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          'Login',
                        ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                color: mobileSearchColor,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              GestureDetector(
                onTap: () => nextPage(context, const SignupScreen()),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
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
