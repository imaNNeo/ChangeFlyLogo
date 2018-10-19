import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChangeFlyLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeFlyLogoState();
}

class _ChangeFlyLogoState extends State<ChangeFlyLogo>
    with SingleTickerProviderStateMixin {
  final double size = 200.0;

  AnimationController controller;

  //Top section animations
  Animation topTranslateAnim;

  //Left section animations
  Animation leftScaleAnim;
  Animation leftTranslateAnim;
  Animation leftRotationXAnim;
  Animation leftRotationYAnim;

  //Right section animations
  Animation rightScaleAnim;
  Animation rightTranslateAnim;
  Animation rightRotationXAnim;
  Animation rightRotationYAnim;

  Curve myCurve = Cubic(0.45,-0.12,1.0,0.85);

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 600));

    controller.addListener(() {
      setState(() {});
    });

    //Top section animations
    topTranslateAnim = new Tween(
        begin: const Offset(0.0, -200.0), end: const Offset(0.0, 0.0))
        .animate(new CurvedAnimation(parent: controller, curve: myCurve));

    //Left section animations
    leftScaleAnim = new Tween(begin: 3.0, end: 1.0)
        .animate(new CurvedAnimation(parent: controller, curve: Curves.ease));

    leftTranslateAnim = new Tween(
        begin: const Offset(-80.0, 80.0), end: Offset.zero)
        .animate(
        new CurvedAnimation(parent: controller, curve: myCurve));

    leftRotationXAnim = new Tween(begin: 1.2, end: 0.0)
        .animate(
        new CurvedAnimation(parent: controller, curve: Curves.linear));

    leftRotationYAnim = new Tween(begin: 0.3, end: 0.0)
        .animate(
        new CurvedAnimation(parent: controller, curve: Curves.linear));


    //Right section animations
    rightScaleAnim = new Tween(begin: 3.0, end: 1.0)
        .animate(new CurvedAnimation(parent: controller, curve: Curves.ease));

    rightTranslateAnim = new Tween(
        begin: const Offset(80.0, 80.0), end: Offset.zero)
        .animate(
        new CurvedAnimation(parent: controller, curve: myCurve));

    rightRotationXAnim = new Tween(begin: -1.2, end: 0.0)
        .animate(
        new CurvedAnimation(parent: controller, curve: Curves.linear));

    rightRotationYAnim = new Tween(begin: 0.3, end: 0.0)
        .animate(
        new CurvedAnimation(parent: controller, curve: Curves.linear));


    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward(from: 0.0);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..translate(
                    topTranslateAnim.value.dx, topTranslateAnim.value.dy),
              child: Image.asset("assets/images/logo/changefly-cube-top.png"),
            ),
            Transform(
              alignment: Alignment(-0.75, 0.1),
              transform: Matrix4.identity()
                ..translate(
                    leftTranslateAnim.value.dx, leftTranslateAnim.value.dy)
                ..scale(leftScaleAnim.value)
                ..rotateX(leftRotationXAnim.value)
                ..rotateY(leftRotationYAnim.value),
              child: Image.asset("assets/images/logo/changefly-cube-left.png"),
            ),
            Transform(
              alignment: Alignment(0.75, 0.1),
              transform: Matrix4.identity()
                ..translate(
                    rightTranslateAnim.value.dx, rightTranslateAnim.value.dx)
                ..scale(rightScaleAnim.value)
                ..rotateX(rightRotationXAnim.value)
                ..rotateY(rightRotationYAnim.value),
              child: Image.asset("assets/images/logo/changefly-cube-right.png"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

class MyCurve extends Curve{
  const MyCurve([this.period = 0.4]);
  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double s = 0.1;
    t = t - 1.0;
    return -math.pow(2.0, 10.0 * t) * math.sin((t - s) * (math.pi * 2.0) / period);
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}