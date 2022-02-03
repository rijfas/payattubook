import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payattubook/core/themes/app_theme.dart';
import 'package:payattubook/logic/discover_payattu/cubit/discover_payattu_cubit.dart';
import 'package:payattubook/presentation/components/rounded_elevated_button.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    context.read<DiscoverPayattuCubit>().loadPayattu();
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
              print('boom');
              return context.read<DiscoverPayattuCubit>().loadPayattu();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppTheme.lightInputBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search),
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search payattu',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.lightSecondaryColor,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Icon(Icons.published_with_changes_sharp)
                        ],
                      ),
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
                        child: ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                state.payattList[index].coverImageUrl),
                          ),
                          title: Text(
                            state.payattList[index].host,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            state.payattList[index].date.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          trailing: Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is DiscoverPayattuError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error'),
            RoundedElevatedButton(
              child: Text('Retry'),
              onPressed: () =>
                  context.read<DiscoverPayattuCubit>().loadPayattu(),
            )
          ],
        );
      }
      return Text('Unknown error');
    });
  }
}
