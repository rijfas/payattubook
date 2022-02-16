import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../components/rounded_profile.dart';
import '../../router/app_router.dart';
import 'pages/calendar_page/calendar_page.dart';
import 'pages/discover_page/discover_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/transactions_page/transactions_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    DiscoverPage(),
    CalendarPage(),
    TransactionPage(),
    // Center(child: Text('Transactions(Coming soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.payattListScreen);
            },
            icon: const Icon(Icons.insert_chart_outlined)),
        centerTitle: true,
        title: const Text('PayattuBook'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouter.profileScreen),
              icon: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationCompleted) {
                  return RoundedProfile(url: state.user.profileUrl);
                }
                return const RoundedProfile(url: '');
              }),
            ),
          )
        ],
      ),
      body: IndexedStack(
        children: _pages,
        index: _currentIndex,
      ),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        dotIndicatorColor: AppTheme.lightPrimaryColor,
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: AppTheme.lightPrimaryColor,
            unselectedColor: AppTheme.lightSecondaryColor,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.search),
            selectedColor: AppTheme.lightPrimaryColor,
            unselectedColor: AppTheme.lightSecondaryColor,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.calendar_today_rounded),
            selectedColor: AppTheme.lightPrimaryColor,
            unselectedColor: AppTheme.lightSecondaryColor,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet_rounded),
            selectedColor: AppTheme.lightPrimaryColor,
            unselectedColor: AppTheme.lightSecondaryColor,
          )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.shifting,
      // currentIndex: _currentIndex,
      // onTap: (index) => setState(() => _currentIndex = index),
      //   showUnselectedLabels: false,
      // items: const [
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.home),
      //     label: 'Home',
      //     backgroundColor: Colors.white,
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.search),
      //     label: 'Discover',
      //     backgroundColor: Colors.white,
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.calendar_today_outlined),
      //     label: 'Calendar',
      //     backgroundColor: Colors.white,
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(Icons.account_balance_wallet_rounded),
      //     label: 'Transactions',
      //     backgroundColor: Colors.white,
      //   )
      // ],
      // ),
      // floatingActionButton: (_currentIndex == 1)
      //     ? FloatingActionButton(
      //         backgroundColor: Theme.of(context).primaryColor,
      //         child: const Icon(
      //           Icons.edit,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(AppRouter.createPayattuScreen);
      //         })
      //     : ((_currentIndex == 3)
      //         ? FloatingActionButton(
      //             backgroundColor: Theme.of(context).primaryColor,
      //             child: const Icon(
      //               Icons.add,
      //               color: Colors.white,
      //             ),
      //             onPressed: () {
      //               Navigator.of(context)
      //                   .pushNamed(AppRouter.createTransactionScreen);
      //             })
      //         : null),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (_currentIndex == 3)
          ? FloatingActionButton(
              backgroundColor: AppTheme.lightPrimaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.transactionsScreen);
              },
            )
          : null,
    );
  }
}
