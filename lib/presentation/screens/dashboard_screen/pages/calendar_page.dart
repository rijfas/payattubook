import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/default_widgets.dart';
import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../components/default_error_widget.dart';
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
      late final String message;
      if (state is ManagePayattuLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ManagePayattuLoaded) {
        return Padding(
          padding: DefaultWidgets.padding,
          child: CalendarPayattuView(payattuList: state.payattuList),
        );
      } else if (state is ManagePayattuError) {
        message = state.message;
      } else {
        message = 'Unknown Error';
      }
      return DefaultErrorWidget(
        message: message,
        onRetry: () => context.read<ManagePayattuCubit>().loadPayattu(),
      );
    });
  }
}
