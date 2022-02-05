import 'package:flutter/material.dart';
import 'package:payattubook/presentation/screens/create_payattu_screen/create_payattu_screen.dart';
import 'package:payattubook/presentation/screens/profile_screen/profile_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/sign_in_screen/sign_in_screen.dart';
import '../screens/sign_up_screen/sign_up_screen.dart';

import '../../core/exceptions/invalid_route_exception.dart';
import '../screens/loading_screen/loading_screen.dart';

class AppRouter {
  const AppRouter._();
  static const greetScreen = 'greet-screen';
  static const loadingScreen = 'loading-screen';
  static const signInScreen = 'sign-in-screen';
  static const signUpScreen = 'sign-up-screen';
  static const dashboardScreen = 'dashboard-screen';
  static const createPayattuScreen = 'create-payattu-screen';
  static const profileScreen = 'profile-screen';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loadingScreen:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case createPayattuScreen:
        return MaterialPageRoute(builder: (_) => const CreatePayattuScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        throw InvalidRouteException(
            "invalid route reached : ${routeSettings.name}");
    }
  }
}
