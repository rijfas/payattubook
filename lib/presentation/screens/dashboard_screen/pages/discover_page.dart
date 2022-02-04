import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../components/bottom_payattu_card.dart';
import '../components/custom_search_bar.dart';
import '../components/custom_input_popup.dart';
import '../../../components/rounded_elevated_button.dart';
import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../components/custom_payattu_tile.dart';

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
    return BlocBuilder<DiscoverPayattuCubit, DiscoverPayattuState>(
        builder: (context, state) {
      if (state is DiscoverPayattuLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is DiscoverPayattuLoaded) {
        return SizedBox(
          height: size.height - kToolbarHeight,
          child: RefreshIndicator(
            onRefresh: () {
              return context.read<DiscoverPayattuCubit>().loadPayattu();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomSearchBar(
                      controller: _searchController,
                      onSearch: () {
                        context.read<DiscoverPayattuCubit>().searchPayattu(
                            hostName: _searchController.value.text);
                      },
                    ),
                    ListView.builder(
                      itemCount: state.payattList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.black12,
                              blurRadius: 5,
                            )
                          ],
                        ),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.defaultErrorImage,
            width: size.width * 0.4,
          ),
          SizedBox(height: size.height * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('An error occured'),
              const SizedBox(width: 4.0),
              InkWell(
                child: const Text(
                  'reload?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => context.read<DiscoverPayattuCubit>().loadPayattu(),
              )
            ],
          )
        ],
      );
    });
  }
}
