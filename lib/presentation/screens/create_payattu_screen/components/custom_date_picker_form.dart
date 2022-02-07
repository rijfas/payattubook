import 'package:flutter/material.dart';

import 'custom_date_picker.dart';

class CustomDatePickerForm extends FormField<DateTime> {
  CustomDatePickerForm({
    Key? key,
    required FormFieldValidator<DateTime> validator,
    required void Function(DateTime?) onDatePicked,
  }) : super(
            key: key,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<DateTime> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDatePicker(onDatePicked: (value) {
                    state.didChange(value);
                    onDatePicked(value);
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
