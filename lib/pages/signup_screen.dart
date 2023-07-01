// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/database/auth_method.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobileLayout.dart';
import '../responsive/webLayout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Uint8List? _image;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Selecting image from file

  void selectImage() async {
    Uint8List pickedImage = await pickImage(ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  bool _isLoading = false;

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      userName: _usernameController.text.trim(),
      bio: _bioController.text.trim(),
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      // showsnackbar of the type of error occured
      showSnackBar(context, res);
    } else {
      showSnackBar(context, res);
      // Navigate to the login page
      nextPageReplacement(
        context,
        const ResponsiveLayout(
          MobileLayout: MobileLayout(),
          WebLayout: WebLayout(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                SvgPicture.asset(
                  'assets/images/ic_instagram.svg',
                  height: 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 20.0),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 60.0,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 50.0,
                            ),
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: mobileBackgroundColor,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: IconButton(
                          onPressed: () => selectImage(),
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFieldInput(
                  hintText: 'Username',
                  textEditingController: _usernameController,
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
                TextFieldInput(
                  hintText: 'Bio',
                  textEditingController: _bioController,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                InkWell(
                  onTap: () => _image != null
                      ? signUpUser()
                      : showSnackBar(context, 'Please enter all the field'),
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
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            'Signup',
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
      ),
    );
  }
}
