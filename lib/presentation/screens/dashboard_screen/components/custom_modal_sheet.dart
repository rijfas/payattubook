import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/assets.dart';
import '../../../../data/manage_payattu/models/user_payattu.dart';
import '../../../../data/payattu/models/payattu.dart';
import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../components/rounded_elevated_button.dart';
import 'custom_icon_tile.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({
    Key? key,
    required final String hostImageUrl,
    required final String hostName,
    required final String date,
    required final String time,
    required final String location,
  })  : _hostImageUrl = hostImageUrl,
        _hostName = hostName,
        _date = date,
        _time = time,
        _location = location,
        super(key: key);
  final String _hostImageUrl;
  final String _hostName;
  final String _date;
  final String _time;
  final String _location;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          right: 15.0,
          left: 15.0,
        ),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: size.width * 0.2,
                foregroundImage: (_hostImageUrl != '')
                    ? CachedNetworkImageProvider(_hostImageUrl)
                    : null,
                backgroundImage: const AssetImage(Assets.defaultProfile),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Text(
              _hostName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),
            SizedBox(height: size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.message)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.account_circle_sharp)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more)),
              ],
            ),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
              icon: Icons.date_range_outlined,
              title: 'Date',
              content: _date,
            ),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
                icon: Icons.access_time_filled_outlined,
                title: 'Time',
                content: _time),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
                icon: Icons.location_on_sharp,
                title: 'Location',
                content: _location),
            SizedBox(height: size.height * 0.025),
            RoundedElevatedButton(
              child: const Text('Add to payattu list'),
              onPressed: () {
                final state = context.read<ManagePayattuCubit>().state;

                final currentPayatts = (state is ManagePayattuLoaded)
                    ? state.payattuList
                    : const <UserPayattu>[];
                context.read<ManagePayattuCubit>().addPayattu(
                    currentPayatts: currentPayatts,
                    payattu: Payattu(
                        createdBy: 'Rijfas',
                        host: 'Rijfas',
                        hostPhoneNumber: 'aasdas',
                        date: DateTime.now(),
                        time: '12 man',
                        location: 'fdsf'),
                    amount: 100);
              },
            ),
            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
