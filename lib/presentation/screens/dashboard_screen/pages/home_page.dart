import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payattubook/logic/manage_payattu/cubit/manage_payattu_cubit.dart';

import '../../../../logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import '../../../components/rounded_elevated_button.dart';
import '../components/custom_search_bar.dart';
import '../components/custom_modal_sheet.dart';

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
    return BlocBuilder<ManagePayattuCubit, ManagePayattuState>(
        builder: (context, state) {
      if (state is ManagePayattuLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ManagePayattuLoaded) {
        return SizedBox(
          height: size.height - kToolbarHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: state.payattuList.length,
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
                      child: ListTile(
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
                              builder: (_) => CustomModalSheet(
                                  hostImageUrl: state
                                      .payattuList[index].payattu.coverImageUrl,
                                  hostName:
                                      state.payattuList[index].payattu.host,
                                  date: state.payattuList[index].payattu.date
                                      .toString(),
                                  time: state.payattuList[index].payattu.time,
                                  location: state
                                      .payattuList[index].payattu.location));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              state.payattuList[index].payattu.coverImageUrl),
                        ),
                        title: Text(
                          state.payattuList[index].payattu.host,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          state.payattuList[index].payattu.date.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        trailing: const Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (state is ManagePayattuError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error'),
            RoundedElevatedButton(
              child: Text('Retry'),
              onPressed: () => context.read<ManagePayattuCubit>().loadPayattu(),
            )
          ],
        );
      }
      return Text('Unknown error');
    });
  }
}
