import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/assets.dart';
import '../../router/app_router.dart';
import 'components/slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  final List<Widget> slides = const [
    Slide(
      slide: Assets.firstOnboardImage,
      title: 'sdfsdf sdfsdf sdfdf',
      subTitle: 'sdfsdfsdfs sdfsdfd dsfsdf sdfsdfsd fsdfsdfsdf',
    ),
    Slide(
      slide: Assets.secondOnboardImage,
      title: 'sdfsffgffh gfhfghg gfh',
      subTitle: 'sdfsdfsdfs sdfhsdfj sfkjsdlkfjs kcjvjc',
    ),
    Slide(
      slide: Assets.thirdOnboardImage,
      title: 'Test sdfsdf sdfsdf',
      subTitle: 'sdfsdfsdfs sfsdfj sdfsfd sdffsdf',
    ),
  ];
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payattu Book',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.signInScreen, (route) => false),
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.tight,
                child: PageView(
                  controller: _controller,
                  children: widget.slides,
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: widget.slides.length,
                effect: WormEffect(
                  offset: 8.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  spacing: 4.0,
                  radius: 8,
                  dotColor: Theme.of(context).disabledColor,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () {
                        if (_controller.page!.toInt() ==
                            widget.slides.length - 1) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouter.signInScreen, (route) => false);
                        } else {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
