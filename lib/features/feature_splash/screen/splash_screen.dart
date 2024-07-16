import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kivi/features/feature_home/screen/home_screen.dart';
import 'package:kivi/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _logoAnimationController;
  late final Animation<double> _fadeAnimation, _scaleAnimation;
  @override
  void initState() {
    _logoAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _initFadeAnimation();
    _initScaleAnimation();
    _runAnimation();
    _naveToHomeScreenListener();

    super.initState();
  }

  void _initFadeAnimation() {
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_logoAnimationController);
  }

  void _initScaleAnimation() {
    _scaleAnimation = CurvedAnimation(
        parent: _logoAnimationController, curve: Curves.easeInOut);
  }

  void _runAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _logoAnimationController.forward();
    });
  }

  void _naveToHomeScreenListener() {
    _logoAnimationController.addListener(() {
      if (_logoAnimationController.isCompleted) {
        Future.delayed(const Duration(milliseconds: 800), () {
          Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
        });
      }
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Assets.images.splashBackground.image(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.cover),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Assets.images.logo.image(
                  width: 180,
                  height: 180,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
