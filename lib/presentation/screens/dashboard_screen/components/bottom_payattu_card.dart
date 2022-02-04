import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/assets.dart';
import '../../../../data/payattu/models/payattu.dart';
import '../../../components/rounded_elevated_button.dart';
import 'custom_icon_tile.dart';

class BottomPayattuCard extends StatelessWidget {
  const BottomPayattuCard({
    Key? key,
    required Payattu payattu,
    required RoundedElevatedButton bottomButton,
  })  : _payattu = payattu,
        _bottomBotton = bottomButton,
        super(key: key);
  final Payattu _payattu;
  final RoundedElevatedButton _bottomBotton;

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
                foregroundImage: (_payattu.coverImageUrl != '')
                    ? CachedNetworkImageProvider(_payattu.coverImageUrl)
                    : null,
                backgroundImage: const AssetImage(Assets.defaultProfile),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Text(
              _payattu.host,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Text('+91${_payattu.hostPhoneNumber}'),
            SizedBox(height: size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(FontAwesomeIcons.whatsapp)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.message)),
              ],
            ),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
              icon: Icons.date_range_outlined,
              title: 'Date',
              content: _payattu.date.toString(),
            ),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
              icon: Icons.access_time_filled_outlined,
              title: 'Time',
              content: _payattu.time,
            ),
            SizedBox(height: size.height * 0.025),
            CustomIconTile(
              icon: Icons.location_on_sharp,
              title: 'Location',
              content: _payattu.location,
            ),
            SizedBox(height: size.height * 0.025),
            _bottomBotton,
            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
