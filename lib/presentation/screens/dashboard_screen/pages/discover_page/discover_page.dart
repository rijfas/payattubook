import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/default_widgets.dart';
import '../../../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../../components/default_error_widget.dart';
import '../../../../components/default_shaded_container.dart';
import '../../../../components/rounded_elevated_button.dart';
import '../../components/amount_popup.dart';
import '../../components/bottom_payattu_card.dart';
import '../../components/custom_search_bar.dart';
import '../../components/payattu_tile.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    context.read<DiscoverPayattuCubit>().loadPayattu();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: DefaultWidgets.padding,
      child: SizedBox(
        height: size.height - kToolbarHeight,
        child: Column(
          children: [
            CustomSearchBar(
              controller: _searchController,
              onSearch: () {
                context
                    .read<DiscoverPayattuCubit>()
                    .searchPayattu(hostName: _searchController.value.text);
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return context.read<DiscoverPayattuCubit>().loadPayattu();
                },
                child: BlocBuilder<DiscoverPayattuCubit, DiscoverPayattuState>(
                    builder: (context, state) {
                  late final String message;
                  if (state is DiscoverPayattuLoading) {
                    return const SizedBox.expand();
                  } else if (state is DiscoverPayattuLoaded) {
                    return ListView.builder(
                      itemCount: state.payattList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => DefaultShadedContainer(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: PayattuTile(
                          payattu: state.payattList[index],
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                minWidth: size.width,
                                maxHeight: size.height,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              context: context,
                              builder: (_) => BottomPayattuCard(
                                payattu: state.payattList[index],
                                bottomButton: RoundedElevatedButton(
                                  child: const Text('Add to payattu list'),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AmountPopup(
                                        title: 'Enter Amount',
                                        onCancell: () =>
                                            Navigator.of(context).pop(false),
                                        onSubmit: (String value) => context
                                            .read<ManagePayattuCubit>()
                                            .addPayattu(
                                              payattu: state.payattList[index],
                                              amount: double.parse(value),
                                            ),
                                      ),
                                    ).then((result) {
                                      if (result) {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          trailing: const Icon(Icons.add),
                        ),
                      ),
                    );
                  } else if (state is DiscoverPayattuError) {
                    message = state.message;
                  } else {
                    message = 'Unknown Error!';
                  }
                  return DefaultErrorWidget(
                    message: message,
                    onRetry: () =>
                        context.read<DiscoverPayattuCubit>().loadPayattu(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
