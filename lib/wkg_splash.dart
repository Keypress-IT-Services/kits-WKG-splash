library wkg_splash;

import 'package:flutter/material.dart';

class WkgSplashScreen extends StatefulWidget {
  final Widget nextRount;
  const WkgSplashScreen({Key? key, required this.nextRount}) : super(key: key);

  @override
  State<WkgSplashScreen> createState() => _WkgSplashScreenState();
}

class _WkgSplashScreenState extends State<WkgSplashScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation1;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation1 = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward().then((value) async {
      await Future.delayed(const Duration(milliseconds: 500));
      controller!.reverse().then((value) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: widget.nextRount,
              );
            },
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff150f15),
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: FadeTransition(
              opacity: animation1!,
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2,
                package: 'wkg_splash',
              )),
        ),
      ),
    );
  }
}
