import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payattubook/presentation/components/default_shaded_container.dart';

import '../../../../core/constants/assets.dart';
import '../../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../components/bottom_payattu_card.dart';
import '../components/custom_search_bar.dart';
import '../components/custom_input_popup.dart';
import '../../../components/rounded_elevated_button.dart';
import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../components/custom_payattu_tile.dart';
import '../../../../core/constants/default_widgets.dart';

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
                        child: CustomPayattuTile(
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
                                      builder: (_) => CustomInputPopup(
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
                        ),
                      ),
                    );
                  } else if (state is DiscoverPayattuError) {
                    message = state.message;
                  } else {
                    message = 'Unknown Error!';
                  }
                  return _buildErrorMessage(message: message);
                }),
              ),
            ),
          ],
        ),
      ),
    );
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
}
