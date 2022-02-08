import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../core/utils/validators.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
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
  Uint8List? _profileImage;
  String? _profileFileName;
  late final TextEditingController _fullNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          Utils.showLoadingDialog(context);
        } else if (state is AuthenticationCompleted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(AppRouter.dashboardScreen);
        } else if (state is AuthenticationError) {
          Navigator.of(context).pop();
          Utils.showErrorSnackBar(context: context, message: state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Center(
                        child: AvatarImagePicker(
                          radius: size.width * 0.25,
                          onProfileChanged: (image, fileName) {
                            _profileImage = image;
                            _profileFileName = fileName;
                          },
                          onProfileDeleted: () {
                            _profileImage = null;
                            _profileFileName = null;
                          },
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
                        keyboardType: TextInputType.name,
                        validator:
                            Validators.defaultStringValidator('full name'),
                        controller: _fullNameController,
                        labelText: 'Full Name',
                        icon: Icons.person,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: size.height * 0.025),
                      UnderlinedIconTextField(
                        keyboardType: TextInputType.text,
                        validator: Validators.defaultStringValidator('address'),
                        controller: _addressController,
                        labelText: 'Address',
                        icon: Icons.home,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: size.height * 0.025),
                      UnderlinedIconTextField(
                        keyboardType: TextInputType.phone,
                        validator: Validators.phoneNumberValidator,
                        controller: _phoneNumberController,
                        labelText: 'Mobile Number',
                        icon: Icons.call,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: size.height * 0.025),
                      UnderlinedIconTextField(
                        keyboardType: TextInputType.text,
                        validator: Validators.passwordValidator,
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: size.height * 0.025),
                      RoundedElevatedButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationCubit>().signUp(
                                  fullName: _fullNameController.value.text,
                                  phoneNumber:
                                      _phoneNumberController.value.text,
                                  password: _passwordController.value.text,
                                  address: _addressController.value.text,
                                  profileImage: _profileImage,
                                  profileFileName: _profileFileName,
                                );
                          }
                        },
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
        ),
      ),
    );
  }
}
