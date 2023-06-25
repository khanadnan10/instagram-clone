import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
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
                hintText: 'Username',
                textEditingController: _emailController,
              ),
              const SizedBox(height: 15.0),
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
                  'Signup',
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
                onTap: () => previousPage(context),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
