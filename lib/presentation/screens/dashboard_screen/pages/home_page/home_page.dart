import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payattubook/presentation/components/default_empty_widget.dart';
import '../../components/amount_popup.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/default_widgets.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../data/discover_payattu/models/payattu.dart';
import '../../../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import 'payattu_expansion_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ManagePayattuCubit>().loadPayattu();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<DiscoverPayattuCubit, DiscoverPayattuState>(
        builder: (context, state) {
      late final String message;
      if (state is DiscoverPayattuLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is DiscoverPayattuLoaded) {
        final _todaysPayatts = _getTodaysPayattu(state.payattList);
        return SizedBox(
          height: size.height - kToolbarHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: DefaultWidgets.padding,
              child: Column(
                children: [
                  ..._buildHeader(title: 'Today\'s Payattu'),
                  if (_todaysPayatts.isNotEmpty)
                    _buildPayattList(payattList: _todaysPayatts)
                  else
                    const DeafultEmptyWidget(message: 'No payattu today'),
                  DefaultWidgets.verticalSpacing(context: context),
                  ..._buildHeader(title: 'Upcoming Payattu'),
                  if (state.payattList.isNotEmpty)
                    _buildPayattList(payattList: state.payattList)
                  else
                    const DeafultEmptyWidget(message: 'No upcoming payattu'),
                ],
              ),
            ),
          ),
        );
      } else if (state is DiscoverPayattuError) {
        message = state.message;
      } else {
        message = 'Unknown error';
      }
      return _buildErrorMessage(message: message);
    });
  }

  List<Payattu> _getTodaysPayattu(List<Payattu> payattList) {
    final today = DateTime.now();
    List<Payattu> payatts = <Payattu>[];
    for (final payattu in payattList) {
      if (Utils.isSameDate(today, payattu.date)) {
        payatts.add(payattu);
      }
    }
    return payatts;
  }

  List<Widget> _buildHeader({required String title}) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
      const Divider(),
    ];
  }

  Widget _buildErrorMessage({required String message}) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultWidgets.verticalSizedBox,
        SvgPicture.asset(
          Assets.defaultErrorImage,
          width: size.width * 0.3,
        ),
        DefaultWidgets.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            DefaultWidgets.horizontalSizedBox,
            InkWell(
              onTap: () => context.read<DiscoverPayattuCubit>().loadPayattu(),
              child: const Text(
                'Retry?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildPayattList({required List<Payattu> payattList}) {
    return ListView.builder(
      itemCount: payattList.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (_, index) => PayattuExpansionTile(
        payattu: payattList[index],
        onPressed: () =>
            readAmount(context: context, payattu: payattList[index]),
      ),
    );
  }
}
