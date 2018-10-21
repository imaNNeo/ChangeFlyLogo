import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Sample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sample3State();
}

class _Sample3State extends State<Sample3> with TickerProviderStateMixin {
  final double size = 200.0;

  /*
  * This animation considered for initial animation (just like the website).
  * in this sample we two sequential animation,
  * first all of cube sections will be rotate 3 times around each other,
  * and will translate from a distance to center (correct position),
  * each cube's section have an angle (-90 for top, 30 for right, 150 for left),
  * and we translate each of them to corresponding angle,
  * and in next animation the title will show with fadeIn effect
  * */
  AnimationController firstController;
  AnimationController secondController;

  // Cube's Sections Translate animations
  Animation topAnimation;
  Animation rightAnimation;
  Animation leftAnimation;

  // Whole cube rotation animation
  Animation rotationAnimation;

  // Logo fadeIn animation
  Animation nameFadeInAnimation;

  @override
  void initState() {
    super.initState();

    double distance = 160.0;

    firstController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    firstController.addListener(() {
      setState(() {});
    });
    firstController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        secondController.forward(from: 0.0);
      } else if (status == AnimationStatus.forward) {
        secondController.value = 0.0;
      }
    });

    secondController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    secondController.addListener(() {
      setState(() {});
    });

    double topAngle = -90.0;
    topAnimation =
        new Tween(begin: getOffset(topAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: firstController, curve: Curves.easeInOut));

    double rightAngle = 30.0;
    rightAnimation =
        new Tween(begin: getOffset(rightAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: firstController, curve: Curves.easeInOut));

    double leftAngle = 150.0;
    leftAnimation =
        new Tween(begin: getOffset(leftAngle, distance), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: firstController, curve: Curves.easeInOut));

    rotationAnimation = new Tween(begin: 360.0 * 3, end: 0).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut));

    nameFadeInAnimation =
        new Tween(begin: 0.0, end: 1.0).animate(secondController);

    firstController.forward(from: 0.0);
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
        firstController.forward(from: 0.0);
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
                  topSection(),
                  rightSection(),
                  leftSection(),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: nameFadeInAnimation.value,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: titleSection(),
            ),
          )
        ],
      ),
    );
  }

  Widget topSection() {
    return Transform(
        transform: Matrix4.identity()
          ..translate(topAnimation.value.dx, topAnimation.value.dy),
        child:
        Image.asset("assets/images/logo/changefly-cube-top.png"));
  }

  Widget rightSection() {
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              rightAnimation.value.dx, rightAnimation.value.dy),
        child: Image.asset(
            "assets/images/logo/changefly-cube-right.png"));
  }

  Widget leftSection() {
    return Transform(
        transform: Matrix4.identity()
          ..translate(leftAnimation.value.dx, leftAnimation.value.dy),
        child: Image.asset(
            "assets/images/logo/changefly-cube-left.png"));
  }

  Widget titleSection() {
    return Image.asset(
      "assets/images/logo/changefly-name.png", width: size * 1.3,);
  }

  /*
  * We should dispose our controllers to prevent leak memory and other consequences
  * */
  @override
  void dispose() {
    super.dispose();
    firstController.dispose();
    secondController.dispose();
  }

  /*
  * These are our utils
  * because in sin / cos functions of Math we have to pass radian.
  * */
  num degToRad(num deg) => deg * (Math.pi / 180.0);
  num radToDeg(num rad) => rad * (180.0 / Math.pi);
}
