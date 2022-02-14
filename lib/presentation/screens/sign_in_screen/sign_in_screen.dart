import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets.dart';
import '../../../core/utils/utils.dart';
import '../../../core/utils/validators.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../components/rounded_elevated_button.dart';
import '../../components/underlined_icon_text_field.dart';
import '../../router/app_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
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
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          Utils.showLoadingDialog(context);
        } else if (state is AuthenticationCompleted) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.dashboardScreen, (_) => false);
        } else if (state is AuthenticationError) {
          Navigator.of(context).pop();
          Utils.showSnackBar(context: context, message: state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height - kToolbarHeight,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(),
                      Center(
                        child: SvgPicture.asset(
                          Assets.signInImage,
                          height: size.height * 0.2,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style:
                                Theme.of(context).textTheme.headline3?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          const Divider(),
                          SizedBox(height: size.height * 0.025),
                          UnderlinedIconTextField(
                            keyboardType: TextInputType.phone,
                            validator: Validators.phoneNumberValidator,
                            controller: _phoneController,
                            labelText: 'Mobile Number',
                            icon: Icons.call,
                            textInputAction: TextInputAction.next,
                          ),
                          UnderlinedIconTextField(
                            validator: Validators.passwordValidator,
                            controller: _passwordController,
                            labelText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: size.height * 0.025),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          RoundedElevatedButton(
                            child: const Text('Sign In'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationCubit>().signIn(
                                    phoneNumber: _phoneController.value.text,
                                    password: _passwordController.value.text);
                              }
                            },
                          ),
                          SizedBox(height: size.height * 0.0125),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Doesn\'t have an account?'),
                              const SizedBox(width: 4.0),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRouter.signUpScreen,
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.025),
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
