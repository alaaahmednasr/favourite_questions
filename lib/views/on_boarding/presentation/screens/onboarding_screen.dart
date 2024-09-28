import 'dart:async';

import 'package:favourite_questions/resources/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../resources/icons/icons.dart';
import '../../../../services/routes/route_service.dart';
import '../../../../utils/enums/route_enum.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 5),
      () async {
        AppRouter.router.pushReplacementNamed(AppRoute.allQuestions.name);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                onBoardingLogo,
                width: 450,
                height: 450,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Favourite Interview Questions'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 35,
                        color: ColorPalette.primaryColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
