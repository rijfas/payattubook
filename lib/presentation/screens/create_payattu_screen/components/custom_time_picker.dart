import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    Key? key,
    required this.onTimePicked,
  }) : super(key: key);
  final void Function(TimeOfDay?) onTimePicked;
  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? _pickedTime;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final pickedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        widget.onTimePicked(pickedTime);
        setState(() {
          _pickedTime = pickedTime;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(Icons.access_time_filled,
                color: Theme.of(context).disabledColor),
            const SizedBox(width: 16.0),
            Text(
              (_pickedTime == null)
                  ? 'Select time'
                  : '${_pickedTime!.hour} : ${_pickedTime!.minute}',
              style: TextStyle(
                fontSize: 16.0,
                color: (_pickedTime == null)
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
