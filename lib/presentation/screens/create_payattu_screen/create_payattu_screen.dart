import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../core/utils/validators.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../../logic/payattu/cubit/payattu_cubit.dart';
import '../../components/avatar_image_picker.dart';
import '../../components/rounded_elevated_button.dart';
import '../../components/underlined_icon_text_field.dart';
import '../../router/app_router.dart';
import 'components/custom_date_picker.dart';
import 'components/custom_time_picker.dart';

class CreatePayattuScreen extends StatefulWidget {
  const CreatePayattuScreen({Key? key}) : super(key: key);

  @override
  _CreatePayattuScreenState createState() => _CreatePayattuScreenState();
}

class _CreatePayattuScreenState extends State<CreatePayattuScreen> {
  Uint8List? _coverImage;
  String? _coverImagefileName;
  DateTime? _date;
  TimeOfDay? _time;
  late final String _profileUrl;
  late final TextEditingController _hostNameController;
  late final TextEditingController _hostPhoneNumberController;
  late final TextEditingController _locationController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final state = context.read<AuthenticationCubit>().state;
    if (state is AuthenticationCompleted) {
      _hostNameController = TextEditingController(text: state.user.fullName);
      _hostPhoneNumberController =
          TextEditingController(text: state.user.phoneNumber);
      _profileUrl = state.user.profileUrl;
    }
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _hostNameController.dispose();
    _locationController.dispose();
    _hostPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Payattu'),
      ),
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: BlocListener<PayattuCubit, PayattuState>(
              listener: (context, state) {
                if (state is PayattuError) {
                  Navigator.of(context).pop();
                  Utils.showErrorSnackBar(
                      context: context, message: state.message);
                } else if (state is PayattuCreated) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.dashboardScreen, (route) => false);
                } else if (state is PayattuLoading) {
                  Utils.showLoadingDialog(context);
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: AvatarImagePicker(
                        profileUrl: _profileUrl,
                        radius: size.width * 0.25,
                        onProfileChanged: (image, fileName) {
                          _coverImage = image;
                          _coverImagefileName = fileName;
                        },
                      ),
                    ),
                    UnderlinedIconTextField(
                      hintText: 'Host name',
                      icon: Icons.person,
                      controller: _hostNameController,
                      validator: Validators.defaultStringValidator('host name'),
                    ),
                    SizedBox(height: size.height * 0.025),
                    UnderlinedIconTextField(
                      hintText: 'Host phone number',
                      icon: Icons.call,
                      controller: _hostPhoneNumberController,
                      validator: Validators.phoneNumberValidator,
                    ),
                    SizedBox(height: size.height * 0.025),
                    CustomDatePicker(
                      onDatePicked: (date) => _date = date,
                    ),
                    SizedBox(height: size.height * 0.025),
                    CustomTimePicker(onTimePicked: (time) => _time = time),
                    SizedBox(height: size.height * 0.025),
                    UnderlinedIconTextField(
                      hintText: 'Location',
                      icon: Icons.location_on,
                      controller: _locationController,
                      validator: Validators.defaultStringValidator('location'),
                    ),
                    SizedBox(height: size.height * 0.025),
                    RoundedElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<PayattuCubit>().createPayattu(
                                host: _hostNameController.value.text,
                                hostPhoneNumber:
                                    _hostPhoneNumberController.value.text,
                                date: _date!,
                                time: _time!,
                                location: _locationController.value.text,
                                coverImageUrl: _profileUrl,
                                coverImage: _coverImage,
                                coverImageFileName: _coverImagefileName,
                              );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
