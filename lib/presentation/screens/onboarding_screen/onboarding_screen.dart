import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:payattubook/presentation/router/app_router.dart';

import '../../../core/constants/assets.dart';
import '../../../core/themes/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    // );
  }

  @override
  void dispose() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark,
    // );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          showDoneButton: true,
          pages: [
            PageViewModel(
              title: "Fractional shares",
              body:
                  "Instead of having to buy an entire share, invest any amount you want.",
              image: SvgPicture.asset(
                Assets.firstOnboardImage,
                width: size.width * 0.4,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Learn as you go",
              body:
                  "Download the Stockpile app and master the market with our mini-lesson.",
              image: SvgPicture.asset(
                Assets.secondOnboardImage,
                width: size.width * 0.4,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Kids and teens",
              body:
                  "Kids and teens can track their stocks 24/7 and place trades that you approve.",
              image: SvgPicture.asset(
                Assets.thirdOnboardImage,
                width: size.width * 0.4,
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.signInScreen, (route) => false),
          onSkip: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.signInScreen, (route) => false),
          showSkipButton: true,

          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:
              const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.arrow_forward),
          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: const EdgeInsets.all(12.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: AppTheme.lightPrimaryColor,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
