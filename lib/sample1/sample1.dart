import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Sample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sample1State();
}

class _Sample1State extends State<Sample1> with TickerProviderStateMixin {
  final double size = 200.0;
  AnimationController topController, rightController, leftController;

  /*
  * This animation considered for loading and indeterminate progresses.
  * in this sample we have three animation that run sequentially,
  * and repeat infinite.
  * each section of the cube will move toward to their angle and back to initial position.
  * and the angles are -90, 30, 150 respectively top, right, left;
  * */
  Animation topAnimation;
  Animation rightAnimation;
  Animation leftAnimation;

  @override
  void initState() {
    super.initState();

    /*
    * Duration to move each cube section,
    * the back animation have separate duration,
    * at all (duration * 2) will take to move and back each section
    * */
    int duration = 260;

    /*
    * Distance to move each cube's section,
    * and all of them has equal distance to animate
    * */
    double distance = 16.0;

    topController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    double topAngle = -90.0;
    topAnimation =
        new Tween(begin: Offset.zero, end: getOffset(topAngle, distance))
            .animate(CurvedAnimation(parent: topController, curve: Curves.easeInOut));
    topController.addListener((){setState(() {});});
    topController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        topController.reverse(from: 1.0);
        rightController.forward(from: 0.0);
      }
    });

    rightController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    double rightAngle = 30.0;
    rightAnimation =
        new Tween(begin: Offset.zero, end: getOffset(rightAngle, distance))
            .animate(CurvedAnimation(parent: rightController, curve: Curves.easeInOut));
    rightController.addListener((){setState(() {});});
    rightController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        rightController.reverse(from: 1.0);
        leftController.forward(from: 0.0);
      }
    });

    leftController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    double leftAngle = 150.0;
    leftAnimation =
        new Tween(begin: Offset.zero, end: getOffset(leftAngle, distance))
            .animate(CurvedAnimation(parent: leftController, curve: Curves.easeInOut));
    leftController.addListener((){setState(() {});});
    leftController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        leftController.reverse(from: 1.0);
        topController.forward(from: 0.0);
      }
    });

    topController.forward(from: 0.0);
  }

  /*
  * To find out the target position of each section according to their angle,
  * and distance, (the distance is constant in our sample)
  * */
  Offset getOffset(double angle, double distance) {
    double x = Math.cos(degToRad(angle)) * distance;
    double y = Math.sin(degToRad(angle)) * distance;
    return new Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: <Widget>[
                topSection(),
                rightSection(),
                leftSection(),
              ],
            ),
    );
  }

  Widget topSection () {
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              topAnimation.value.dx, topAnimation.value.dy),
        child: Image.asset(
            "assets/images/logo/changefly-cube-top.png"));
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
          ..translate(
              leftAnimation.value.dx, leftAnimation.value.dy),
        child: Image.asset(
            "assets/images/logo/changefly-cube-left.png"));
  }

  /*
  * We should dispose our controllers to prevent leak memory and other consequences
  * */
  @override
  void dispose() {
    super.dispose();
    topController.dispose();
    rightController.dispose();
    leftController.dispose();
  }

  /*
  * These are our utils
  * because in sin / cos functions of Math we have to pass radian.
  * */
  num degToRad(num deg) => deg * (Math.pi / 180.0);
  num radToDeg(num rad) => rad * (180.0 / Math.pi);

}
