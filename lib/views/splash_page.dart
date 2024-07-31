import 'package:flutter/material.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/views/home_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAinmation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/image/mosque 1.png',
              width: MediaQuery.sizeOf(context).width * .7,
              height: MediaQuery.sizeOf(context).height * .4,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              AnimatedBuilder(
                animation: slidingAinmation,
                builder: (context, child) {
                  return SlideTransition(
                    position: slidingAinmation,
                    child: Text(
                      'N o u r y',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        color: fourColor,
                      ),
                    ),
                  );
                },
              ),
              Text(
                'How to be muslim..',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: threeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    slidingAinmation =
        Tween<Offset>(begin: const Offset(0, 4), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  navigateToHome() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    });
  }
}
