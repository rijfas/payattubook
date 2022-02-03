import 'package:flutter/material.dart';
import 'custom_icon_tile.dart';
import '../../../components/rounded_elevated_button.dart';

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
                backgroundImage: NetworkImage(_hostImageUrl),
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
              onPressed: () {},
            ),
            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
