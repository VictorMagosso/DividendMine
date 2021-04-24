import 'package:DividendMine/core/app_images.dart';
import 'package:flutter/material.dart';

class LogoAnimatedWidget extends StatefulWidget {
  @override
  _LogoAnimatedWidgetState createState() => _LogoAnimatedWidgetState();
}

class _LogoAnimatedWidgetState extends State<LogoAnimatedWidget>
    with TickerProviderStateMixin {
  var rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    rotationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 180,
        width: 180,
        child: Stack(
          children: [
            RotationTransition(
              turns: Tween(
                begin: 1.0,
                end: 0.0,
              ).animate(rotationController),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.logoanim), scale: 0.5)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.logostatic), scale: 6)),
            )
          ],
        ),
      ),
    );
  }
}
