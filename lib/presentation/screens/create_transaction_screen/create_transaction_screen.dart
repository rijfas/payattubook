import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/validators.dart';
import '../../../logic/transactions/cubit/transactions_cubit.dart';
import '../../components/rounded_elevated_button.dart';
import '../../components/underlined_icon_text_field.dart';
import '../create_payattu_screen/components/custom_date_picker_form.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({Key? key}) : super(key: key);

  @override
  _CreateTransactionScreenState createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  late final TextEditingController _recipientNameController;
  DateTime? _date;
  late final TextEditingController _amountController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _recipientNameController = TextEditingController();
    _amountController = TextEditingController();
    _date = DateTime.now();
  }

  @override
  void dispose() {
    _recipientNameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Transaction'),
      ),
      body: BlocListener<TransactionsCubit, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionsAdded) {
            Navigator.of(context).pop();
          }
        },
        child: SafeArea(
            child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    UnderlinedIconTextField(
                      keyboardType: TextInputType.name,
                      labelText: 'Host name',
                      icon: Icons.person,
                      controller: _recipientNameController,
                      validator:
                          Validators.defaultStringValidator('recipient name'),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: size.height * 0.025),
                    CustomDatePickerForm(
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      onDatePicked: (value) => _date = value,
                    ),
                    SizedBox(height: size.height * 0.025),
                    UnderlinedIconTextField(
                      keyboardType: TextInputType.text,
                      labelText: 'Amount',
                      icon: FontAwesomeIcons.rupeeSign,
                      controller: _amountController,
                      validator: Validators.amountValidator,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: size.height * 0.025),
                    RoundedElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<TransactionsCubit>().addTransaction(
                                recipient: _recipientNameController.value.text,
                                amount:
                                    double.parse(_amountController.value.text),
                                date: _date!,
                              );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
