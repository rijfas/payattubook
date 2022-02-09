import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/default_widgets.dart';
import '../../../core/utils/utils.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../components/avatar_image_picker.dart';
import '../../components/default_error_widget.dart';
import '../../components/underlined_icon_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          Navigator.of(context).pop();
          Utils.showLoadingDialog(context);
        } else if (state is ProfileChangeLoading) {
          Utils.showLoadingDialog(context);
        } else if (state is AuthenticationError) {
          Navigator.of(context).pop();
          Utils.showSnackBar(context: context, message: state.message);
        } else if (state is AuthenticationCompleted) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                late final String message;
                if (state is AuthenticationLoading) {
                  return const SizedBox();
                } else if (state is AuthenticationCompleted) {
                  return Column(
                    children: [
                      AvatarImagePicker(
                        radius: size.width * 0.2,
                        profileUrl: state.user.profileUrl,
                        onProfileChanged: (image, fileName) {
                          if (image != null) {
                            context.read<AuthenticationCubit>().updateProfile(
                                currentProfile: state.user,
                                image: image,
                                fileName: fileName);
                          }
                        },
                        onProfileDeleted: () {
                          context
                              .read<AuthenticationCubit>()
                              .deleteProfile(currentProfile: state.user);
                        },
                      ),
                      DefaultWidgets.verticalSizedBox,
                      ListTile(
                        selected: true,
                        leading: Icon(Icons.person),
                        title: Text('Name'),
                        subtitle: Text(state.user.fullName),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          final TextEditingController textEditingController =
                              TextEditingController(text: state.user.fullName);
                          final formKey = GlobalKey<FormState>();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  right: size.width * 0.05,
                                  left: size.width * 0.05,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultWidgets.verticalSizedBox,
                                    const Text('Enter your name'),
                                    DefaultWidgets.verticalSizedBox,
                                    UnderlinedIconTextField(
                                      autoFocus: true,
                                      icon: Icons.person,
                                      controller: textEditingController,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          child: const Text('cancel'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        DefaultWidgets.horizontalSizedBox,
                                        ElevatedButton(
                                          child: const Text('save'),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<AuthenticationCubit>()
                                                  .updateName(
                                                      name:
                                                          textEditingController
                                                              .value.text);
                                            }
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      DefaultWidgets.verticalSizedBox,
                      ListTile(
                        selected: true,
                        leading: Icon(Icons.house),
                        title: Text('Address'),
                        subtitle: Text(state.user.address),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          final TextEditingController textEditingController =
                              TextEditingController(text: state.user.address);
                          final formKey = GlobalKey<FormState>();

                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  right: size.width * 0.05,
                                  left: size.width * 0.05,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefaultWidgets.verticalSizedBox,
                                    const Text('Enter your address'),
                                    DefaultWidgets.verticalSizedBox,
                                    UnderlinedIconTextField(
                                        autoFocus: true,
                                        icon: Icons.home,
                                        controller: textEditingController),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          child: const Text('cancel'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        DefaultWidgets.horizontalSizedBox,
                                        ElevatedButton(
                                          child: const Text('save'),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<AuthenticationCubit>()
                                                  .updateAddress(
                                                      address:
                                                          textEditingController
                                                              .value.text);
                                            }
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      DefaultWidgets.verticalSizedBox,
                      ListTile(
                          selected: true,
                          leading: const Icon(Icons.phone),
                          title: const Text('Phone'),
                          subtitle: Text('+91${state.user.phoneNumber}')),
                    ],
                  );
                } else if (state is ProfileChangeLoading) {
                  return const SizedBox();
                } else if (state is AuthenticationError) {
                  message = 'Authentication error, please login to continue';
                }
                message = 'Unknown Error';
                return DefaultErrorWidget(
                  message: message,
                  onRetry: () => context.read<AuthenticationCubit>().signOut(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
