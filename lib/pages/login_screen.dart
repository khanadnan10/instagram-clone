import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

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
                hintText: 'Enter your email',
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textEditingController: _passwordController,
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
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                child: const Text(
                  'Login',
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
              RichText(
                  text: const TextSpan(children: [
                TextSpan(text: "Don't have an account? "),
                TextSpan(
                  text: 'Sign up',
                  style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
