import 'package:fic10_cbt/core/extensions/build_context_ext.dart';
import 'package:fic10_cbt/data/datasources/onboarding_local_datasource.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../auth/pages/login_page.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_indicator.dart';
import '../widgets/skip_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  final pageController = PageController();

  final onboardingData = [
    OnboardingModel(
      image: Assets.images.onboarding.screen1.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
    OnboardingModel(
      image: Assets.images.onboarding.screen2.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
    OnboardingModel(
      image: Assets.images.onboarding.screen3.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
  ];

  void navigate() {
    context.pushReplacement(const LoginPage());
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.onboarding.ornament.path),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              SkipButton(onPressed: () async {
                await OnboardingLocalDatasource().saveOnboardingPassed();
                navigate();
              }),
              OnboardingContent(
                pageController: pageController,
                onPageChanged: (index) {
                  currentPage = index;
                  setState(() {});
                },
                contents: onboardingData,
              ),
              OnboardingIndicator(
                length: onboardingData.length,
                currentPage: currentPage,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Button.filled(
                  onPressed: () {
                    if (currentPage < onboardingData.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      currentPage++;
                      setState(() {});
                    } else {
                      OnboardingLocalDatasource().saveOnboardingPassed();
                      navigate();
                    }
                  },
                  label: 'Continue',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
