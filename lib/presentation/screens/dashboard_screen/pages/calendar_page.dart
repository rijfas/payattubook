import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../components/rounded_elevated_button.dart';
import '../components/calendar_payattu_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    context.read<ManagePayattuCubit>().loadPayattu();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagePayattuCubit, ManagePayattuState>(
        builder: (context, state) {
      if (state is ManagePayattuLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ManagePayattuLoaded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CalendarPayattuView(payattuList: state.payattuList),
        );
      } else if (state is ManagePayattuError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error'),
            RoundedElevatedButton(
              child: const Text('Retry'),
              onPressed: () => context.read<ManagePayattuCubit>().loadPayattu(),
            )
          ],
        );
      }
      return const Text('Unknown error');
    });
  }
}
