import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Text('home'),
    Text('Discover'),
    Text('Transactions'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  backgroundImage: NetworkImage(state.user.profileUrl),
                );
              }
              return CircleAvatar(child: Image.asset(Assets.defaultProfile));
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
    );
  }
}
