import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/validators.dart';
import '../../../components/underlined_icon_text_field.dart';

class AmountPopup extends StatelessWidget {
  AmountPopup({
    Key? key,
    required this.title,
    required this.onSubmit,
    TextEditingController? inputController,
    this.onCancell,
  })  : _inputController = inputController ?? TextEditingController(),
        _key = GlobalKey<FormState>(),
        super(key: key);
  final String title;
  final void Function(String) onSubmit;
  final void Function()? onCancell;
  final TextEditingController _inputController;
  final GlobalKey<FormState> _key;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: AlertDialog(
        title: Text(
          title,
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
              onPressed: () {
                if (onCancell != null) {
                  onCancell!();
                }
                Navigator.of(context).pop(true);
              }),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              if (_key.currentState!.validate()) {
                onSubmit(_inputController.value.text);
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
