import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    required this.onDatePicked,
  }) : super(key: key);
  final void Function(DateTime?) onDatePicked;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _pickedDate;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030, 1, 1),
        );
        widget.onDatePicked(pickedDate);
        setState(() {
          _pickedDate = pickedDate;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(Icons.date_range_rounded,
                color: Theme.of(context).disabledColor),
            const SizedBox(width: 16.0),
            Text(
              (_pickedDate == null)
                  ? 'Select date'
                  : '${_pickedDate!.day} / ${_pickedDate!.month} / ${_pickedDate!.year}',
              style: TextStyle(
                fontSize: 16.0,
                color: (_pickedDate == null)
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
