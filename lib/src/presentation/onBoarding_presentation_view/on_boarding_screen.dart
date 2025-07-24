import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/src/presentation/onBoarding_presentation_view/animated_dot.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/src/auth/presntation_view/views/login_screen.dart';
import 'package:e_triad/src/presentation/onBoarding_presentation_view/onboarding_info_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                allowImplicitScrolling: true,
                controller: pageController,
                children: [
                  OnboardingInfoSection.second(),
                  OnboardingInfoSection.first(),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AnimatedDot(
                          isDotActive: index == _selectedIndex,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 46),
                  RoundedButton(
                    onPressed: () {
                      if (_selectedIndex == 0) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        sl<CacheHelper>().cacheFirstTimer();
                        context.go(LoginScreen.path);
                      }
                    },
                    backgroundColor: Colours.darkBottomButton,
                    text: _selectedIndex == 0 ? 'Next' : 'Get Started',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
