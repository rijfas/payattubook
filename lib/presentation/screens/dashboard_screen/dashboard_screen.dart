import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../router/app_router.dart';
import 'pages/calendar_page.dart';
import 'pages/discover_page.dart';
import 'pages/home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CalendarPage(),
    DiscoverPage(),
    Center(child: Text('Transactions(Coming soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        centerTitle: true,
        title: const Text('PayattuBook'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
              if (state is AuthenticationCompleted &&
                  state.user.profileUrl != '') {
                return CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    state.user.profileUrl,
                  ),
                );
              }
              return IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle,
                    size: 36.0,
                  ));
            }),
          )
        ],
      ),
      body: IndexedStack(
        children: _pages,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Calendar',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Transactions',
            backgroundColor: Colors.white,
          )
        ],
      ),
      floatingActionButton: (_currentIndex == 2)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.createPayattuScreen);
              })
          : null,
    );
  }
}
