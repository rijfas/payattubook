import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/default_empty_widget.dart';

import '../../../core/constants/default_widgets.dart';
import '../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../dashboard_screen/components/payattu_tile.dart';

class PayattListScreen extends StatefulWidget {
  const PayattListScreen({Key? key}) : super(key: key);

  @override
  State<PayattListScreen> createState() => _PayattListScreenState();
}

class _PayattListScreenState extends State<PayattListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ManagePayattuCubit>().loadPayattu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payatt List'),
      ),
      body: BlocBuilder<ManagePayattuCubit, ManagePayattuState>(
          builder: (context, state) {
        if (state is ManagePayattuLoaded) {
          if (state.payattuList.isEmpty) {
            return const Center(
              child: DeafultEmptyWidget(
                  message: 'No payatts added to payatt list'),
            );
          }
          return Padding(
            padding: DefaultWidgets.padding,
            child: ListView.builder(
              itemCount: state.payattuList.length,
              itemBuilder: (context, index) =>
                  PayattuTile(payattu: state.payattuList[index].payattu),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
