import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/themes/app_theme.dart';
import '../../components/rounded_elevated_button.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/default_widgets.dart';
import '../../../core/utils/utils.dart';
import '../../../data/discover_payattu/models/payattu.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../../logic/create_payattu/cubit/create_payattu_cubit.dart';
import '../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../../components/confirm_popup.dart';
import '../../components/default_empty_widget.dart';
import '../../router/app_router.dart';
import '../dashboard_screen/components/payattu_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (index) {
            if (index == 1) {
              Navigator.of(context).pushNamed(AppRouter.editProfileScreen);
            } else if (index == 2) {
              context.read<AuthenticationCubit>().signOut().then((value) =>
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.signInScreen, (route) => false));
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 1,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Sign out'),
              ),
            ];
          },
        )
      ]),
      body: BlocListener<CreatePayattuCubit, CreatePayattuState>(
        listener: (context, state) {
          if (state is CreatePayattuLoading) {
            Utils.showLoadingDialog(context);
          } else if (state is CreatePayattuError) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context: context, message: state.message);
          } else if (state is CreatePayattuCompleted) {
            context
                .read<DiscoverPayattuCubit>()
                .loadPayattu()
                .then((_) => Navigator.of(context).pop());
          }
        },
        child: SizedBox(
          height: size.height - kToolbarHeight,
          width: double.infinity,
          child: SingleChildScrollView(
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationCompleted) {
                  return Padding(
                    padding: DefaultWidgets.padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.2,
                          foregroundImage: (state.user.profileUrl != '')
                              ? CachedNetworkImageProvider(
                                  state.user.profileUrl)
                              : null,
                          backgroundImage:
                              const AssetImage(Assets.defaultProfile),
                        ),
                        DefaultWidgets.verticalSpacing(context: context),
                        Text(
                          state.user.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        DefaultWidgets.verticalSizedBox,
                        Text(
                          '+91${state.user.phoneNumber}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16.0,
                          ),
                        ),
                        // DefaultWidgets.verticalSizedBox,
                        // RoundedElevatedButton(
                        //   child: Padding(
                        //     padding:
                        //         const EdgeInsets.symmetric(horizontal: 16.0),
                        //     child: Text(
                        //       'Host Payattu',
                        //       style: TextStyle(fontSize: 18.0),
                        //     ),
                        //   ),
                        //   shrinkWrap: true,
                        // onPressed: () => Navigator.of(context)
                        //     .pushNamed(AppRouter.hostPayattuScreen),
                        // ),
                        DefaultWidgets.verticalSpacing(context: context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'User\'s Payattu',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  Utils.showSnackBar(
                                      context: context,
                                      message:
                                          'List of payatts created by you');
                                },
                                child: const Text(
                                  '?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        BlocBuilder<DiscoverPayattuCubit, DiscoverPayattuState>(
                            builder: (context, state) {
                          late final String message;
                          if (state is DiscoverPayattuLoaded) {
                            final List<Payattu> _userPayatts =
                                _getUserPayattList(
                                    Utils.supabase.auth.currentUser!.id,
                                    state.payattList);
                            if (_userPayatts.isEmpty) {
                              return const DeafultEmptyWidget(
                                  message: 'No payatts created so far..');
                            }
                            return ListView.separated(
                                separatorBuilder: ((context, index) =>
                                    const Divider()),
                                shrinkWrap: true,
                                itemCount: _userPayatts.length,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) => PayattuTile(
                                      payattu: _userPayatts[index],
                                      trailing: IconButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed(
                                                  AppRouter.hostPayattuScreen,
                                                  arguments:
                                                      _userPayatts[index]),
                                          icon: Icon(Icons.qr_code)),
                                      // trailing: IconButton(
                                      //   onPressed: () async {
                                      //     final confirmDelete =
                                      //         await showDialog<bool>(
                                      //       context: context,
                                      //       builder: (context) => ConfirmPopup(
                                      //         title: 'Confirm delete?',
                                      //         message:
                                      //             'Delete the payattu ${_userPayatts[index].host}',
                                      //       ),
                                      //     );
                                      //     if (confirmDelete ?? false) {
                                      //       context
                                      //           .read<CreatePayattuCubit>()
                                      //           .deletePayattu(
                                      //               payattId:
                                      //                   _userPayatts[index].id);
                                      //     }
                                      //   },
                                      //   icon: Icon(
                                      //     Icons.delete,
                                      //     color: Theme.of(context).primaryColor,
                                      //   ),
                                      // ),
                                    )
                                // Dismissible(
                                //   confirmDismiss: (direct) {
                                // return showDialog<bool>(
                                //   context: context,
                                //   builder: (context) => ConfirmPopup(
                                //     title: 'Confirm delete?',
                                //     message:
                                //         'Delete the payattu ${_userPayatts[index].host}',
                                //   ),
                                // );
                                //   },
                                //   key: Key(index.toString()),
                                //   child: PayattuExpansionTile(
                                //       payattu: _userPayatts[index]),
                                //   onDismissed: (_) {
                                // context
                                //     .read<CreatePayattuCubit>()
                                //     .deletePayattu(
                                //         payattId: _userPayatts[index].id);
                                //   },
                                // ),
                                );
                          } else if (state is DiscoverPayattuLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is DiscoverPayattuError) {
                            message = state.message;
                          } else {
                            message = 'Unknown Error';
                          }
                          return _buildErrorMessage(message: message);
                        })
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppTheme.lightPrimaryColor,
      //   child: const Icon(
      //     Icons.event_note,
      //     color: Colors.white,
      //   ),
      //   onPressed: () =>
      //       Navigator.of(context).pushNamed(AppRouter.hostPayattuScreen),
      // ),
    );
  }

  List<Payattu> _getUserPayattList(String user, List<Payattu> payattList) {
    List<Payattu> userPayattList = <Payattu>[];
    for (final payattu in payattList) {
      if (payattu.createdBy == user) {
        userPayattList.add(payattu);
      }
    }
    return userPayattList;
  }

  Widget _buildErrorMessage({required String message}) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultWidgets.verticalSizedBox,
        SvgPicture.asset(
          Assets.defaultErrorImage,
          width: size.width * 0.3,
        ),
        DefaultWidgets.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            DefaultWidgets.horizontalSizedBox,
            InkWell(
              onTap: () => context.read<DiscoverPayattuCubit>().loadPayattu(),
              child: const Text(
                'Retry?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
