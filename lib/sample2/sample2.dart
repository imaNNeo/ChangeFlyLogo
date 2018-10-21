import 'package:flutter/material.dart';
import 'dart:math' as Math;

class Sample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sample2State();
}

class _Sample2State extends State<Sample2> with TickerProviderStateMixin {
  final double size = 200.0;
  AnimationController topController, rightController, leftController;

  /*
  * This animation considered for loading and indeterminate progresses.
  * in this sample we have three animation that run sequentially,
  * and repeat infinite.
  * each section of the cube's size will scale up and down back to initial size;
  * */
  Animation topAnimation;
  Animation rightAnimation;
  Animation leftAnimation;

  @override
  void initState() {
    super.initState();

    /*
    * Duration that take to scale up
    * and scale down (separately)
    * */
    int duration = 260;

    /*
    * target size scale for all of sections of cube
    * */
    double scaleTo = 1.1;

    topController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    topAnimation =
        new Tween(begin: 1.0, end: scaleTo)
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
    rightAnimation =
        new Tween(begin: 1.0, end: scaleTo)
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
    leftAnimation =
        new Tween(begin: 1.0, end: scaleTo)
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
            )
    );
  }

  Widget topSection() {
    return Transform(alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(topAnimation.value, topAnimation.value),
        child: Image.asset(
            "assets/images/logo/changefly-cube-top.png"));
  }

  Widget rightSection() {
    return Transform(alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(rightAnimation.value, rightAnimation.value),
        child: Image.asset(
            "assets/images/logo/changefly-cube-right.png"));
  }

  Widget leftSection() {
    return Transform(alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(leftAnimation.value, leftAnimation.value),
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

}