import 'package:flutter/material.dart';

class CustomIconTile extends StatelessWidget {
  const CustomIconTile({
    Key? key,
    required IconData icon,
    required String title,
    required String content,
  })  : _icon = icon,
        _title = title,
        _content = content,
        super(key: key);
  final IconData _icon;
  final String _title;
  final String _content;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(_icon),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            Text(_content)
          ],
        )
      ],
    );
  }
}
