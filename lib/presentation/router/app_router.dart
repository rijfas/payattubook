import 'package:flutter/material.dart';

import '../../core/exceptions/invalid_route_exception.dart';
import '../screens/create_payattu_screen/create_payattu_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/edit_profile_screen/edit_profile_screen.dart';
import '../screens/notifications_screen/payatt_list_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/profile_screen/profile_screen.dart';
import '../screens/sign_in_screen/sign_in_screen.dart';
import '../screens/sign_up_screen/sign_up_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/transactions_screen/transactions_screen.dart';

class AppRouter {
  const AppRouter._();
  static const greetScreen = 'greet-screen';
  static const splashScreen = 'splash-screen';
  static const signInScreen = 'sign-in-screen';
  static const signUpScreen = 'sign-up-screen';
  static const dashboardScreen = 'dashboard-screen';
  static const createPayattuScreen = 'create-payattu-screen';
  static const profileScreen = 'profile-screen';
  static const editProfileScreen = 'edit-profile-screen';
  static const payattListScreen = 'payatt-list-screen';
  static const onboardingScreen = 'onboarding-screen';
  static const transactionsScreen = 'transactions-screen';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
      case editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case payattListScreen:
        return MaterialPageRoute(builder: (_) => const PayattListScreen());
      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case transactionsScreen:
        return MaterialPageRoute(builder: (_) => const TransactionsScreen());
      default:
        throw InvalidRouteException(
            "invalid route reached : ${routeSettings.name}");
    }
  }
}
