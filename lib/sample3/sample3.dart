import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Sample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sample3State();
}

class _Sample3State extends State<Sample3> with TickerProviderStateMixin {
  final double size = 200.0;
  AnimationController translateController;
  AnimationController nameShowController;

  Animation topAnimation;
  Animation rightAnimation;
  Animation leftAnimation;
  Animation rotationAnimation;
  Animation nameFadeInAnimation;

  @override
  void initState() {
    super.initState();
    double distance = 160.0;

    translateController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    translateController.addListener(() {
      setState(() {});
    });
    translateController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        nameShowController.forward(from: 0.0);
      } else if (status == AnimationStatus.forward) {
        nameShowController.value = 0.0;
      }
    });

    nameShowController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    nameShowController.addListener(() {
      setState(() {});
    });

    double topAngle = -90.0;
    topAnimation =
        new Tween(begin: getOffset(topAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: translateController, curve: Curves.easeInOut));

    double rightAngle = 30.0;
    rightAnimation =
        new Tween(begin: getOffset(rightAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: translateController, curve: Curves.easeInOut));

    double leftAngle = 150.0;
    leftAnimation =
        new Tween(begin: getOffset(leftAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: translateController, curve: Curves.easeInOut));

    rotationAnimation = new Tween(begin: 360.0 * 3, end: 0).animate(
        CurvedAnimation(parent: translateController, curve: Curves.easeInOut));

    nameFadeInAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(nameShowController);

    translateController.forward(from: 0.0);
  }

  Offset getOffset(double angle, double distance) {
    double x = Math.cos(degToRad(angle)) * distance;
    double y = Math.sin(degToRad(angle)) * distance;
    return new Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        translateController.forward(from: 0.0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: Transform.rotate(
              angle: degToRad(rotationAnimation.value),
              child: Stack(
                children: <Widget>[
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(topAnimation.value.dx, topAnimation.value.dy),
                      child:
                          Image.asset("assets/images/logo/changefly-cube-top.png")),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            rightAnimation.value.dx, rightAnimation.value.dy),
                      child: Image.asset(
                          "assets/images/logo/changefly-cube-right.png")),
                  Transform(
                      transform: Matrix4.identity()
                        ..translate(leftAnimation.value.dx, leftAnimation.value.dy),
                      child: Image.asset(
                          "assets/images/logo/changefly-cube-left.png")),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: nameFadeInAnimation.value,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Image.asset(
                "assets/images/logo/changefly-name.png", width: size * 1.3,),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    translateController.dispose();
    nameShowController.dispose();
  }

  num degToRad(num deg) => deg * (Math.pi / 180.0);

  num radToDeg(num rad) => rad * (180.0 / Math.pi);
}
