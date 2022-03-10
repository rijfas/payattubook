import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payattubook/core/constants/assets.dart';
import 'package:payattubook/core/utils/utils.dart';
import 'package:payattubook/core/utils/validators.dart';
import 'package:payattubook/presentation/components/rounded_elevated_button.dart';
import 'package:payattubook/presentation/components/underlined_icon_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height - kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.forgetPasswordImage,
                    height: size.height * 0.2,
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    children: [
                      Text(
                        'Reset Password',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(height: size.height * 0.025),
                  UnderlinedIconTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                    textInputAction: TextInputAction.next,
                    validator: Validators.defaultStringValidator('email'),
                  ),
                  SizedBox(height: size.height * 0.025),
                  RoundedElevatedButton(
                    child: const Text('Get reset link'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Utils.showSnackBar(
                            context: context,
                            message: 'reset link send to email');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
