import 'package:flutter/material.dart';

import 'custom_time_picker.dart';

class CustomTimePickerForm extends FormField<TimeOfDay> {
  CustomTimePickerForm({
    Key? key,
    required FormFieldValidator<TimeOfDay> validator,
    required void Function(TimeOfDay?) onTimePicked,
  }) : super(
            key: key,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<TimeOfDay> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTimePicker(onTimePicked: (value) {
                    state.didChange(value);
                    onTimePicked(value);
                  }),
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      Column(
                        children: [
                          if (state.hasError)
                            Text(
                              state.errorText!,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 12.0,
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            });
}
