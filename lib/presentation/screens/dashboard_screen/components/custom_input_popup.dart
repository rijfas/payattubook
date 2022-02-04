import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payattubook/presentation/components/underlined_icon_text_field.dart';

class CustomInputPopup extends StatelessWidget {
  CustomInputPopup({
    Key? key,
    required String title,
    required void Function() onCancell,
    required void Function(String) onSubmit,
  })  : _title = title,
        _onCancell = onCancell,
        _onSubmit = onSubmit,
        _inputController = TextEditingController(),
        super(key: key);
  final String _title;
  final void Function() _onCancell;
  final void Function(String) _onSubmit;
  final TextEditingController _inputController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: UnderlinedIconTextField(
        hintText: 'Eg.500',
        icon: FontAwesomeIcons.rupeeSign,
        controller: _inputController,
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('CANCEL'),
          onPressed: _onCancell,
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            _onSubmit(_inputController.value.text);
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
