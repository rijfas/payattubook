import 'package:flutter/material.dart';

import '../../components/avatar_image_picker.dart';
import '../../components/rounded_elevated_button.dart';
import '../../components/underlined_icon_text_field.dart';
import '../../router/app_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Center(
                    child: AvatarImagePicker(
                      radius: size.width * 0.25,
                      onProfileChanged: (image, fileName) {},
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  UnderlinedIconTextField(
                    controller: _phoneController,
                    hintText: 'Full Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: size.height * 0.025),
                  UnderlinedIconTextField(
                    controller: _phoneController,
                    hintText: 'Address',
                    icon: Icons.home,
                  ),
                  SizedBox(height: size.height * 0.025),
                  UnderlinedIconTextField(
                    controller: _phoneController,
                    hintText: 'Mobile Number',
                    icon: Icons.call,
                  ),
                  SizedBox(height: size.height * 0.025),
                  UnderlinedIconTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.025),
                  RoundedElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () {},
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 4.0),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRouter.signInScreen,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
