import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/validators.dart';
import '../../../components/underlined_icon_text_field.dart';

class AmountPopup extends StatelessWidget {
  AmountPopup({
    Key? key,
    required String title,
    required void Function() onCancell,
    required void Function(String) onSubmit,
  })  : _title = title,
        _onCancell = onCancell,
        _onSubmit = onSubmit,
        _inputController = TextEditingController(),
        _key = GlobalKey<FormState>(),
        super(key: key);
  final String _title;
  final void Function() _onCancell;
  final void Function(String) _onSubmit;
  final TextEditingController _inputController;
  final GlobalKey<FormState> _key;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: AlertDialog(
        title: Text(
          _title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        content: UnderlinedIconTextField(
          hintText: 'Eg.500',
          icon: FontAwesomeIcons.rupeeSign,
          controller: _inputController,
          validator: Validators.amountValidator,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Cancell'),
            onPressed: _onCancell,
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              if (_key.currentState!.validate()) {
                _onSubmit(_inputController.value.text);
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
