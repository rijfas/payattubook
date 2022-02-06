import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/default_widgets.dart';
import '../../../core/utils/utils.dart';
import '../../../data/discover_payattu/models/payattu.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../dashboard_screen/components/payattu_expansion_tile.dart';

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
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SizedBox(
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
                        radius: size.width * 0.3,
                        foregroundImage: (state.user.profileUrl != '')
                            ? CachedNetworkImageProvider(state.user.profileUrl)
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
                                Utils.showErrorSnackBar(
                                    context: context,
                                    message: 'Swipe left to delete');
                              },
                              child: const Text(
                                '?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                          final List<Payattu> _userPayatts = _getUserPayattList(
                              Utils.supabase.auth.currentUser!.id,
                              state.payattList);
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: _userPayatts.length,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) => Dismissible(
                                    confirmDismiss: (direct) {
                                      return showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                  'Confirm delete?',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                content: Text(
                                                    'Delete the payattu ${_userPayatts[index].host}'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child:
                                                        const Text('Cancell'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.red[400],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                    child: const Text('Delete'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                  ),
                                                ],
                                              ));
                                    },
                                    key: Key(index.toString()),
                                    child: PayattuExpansionTile(
                                        payattu: _userPayatts[index]),
                                  ));
                        } else if (state is DiscoverPayattuLoading) {
                          return const CircularProgressIndicator();
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
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
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
