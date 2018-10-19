import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChangeFlyLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeFlyLogoState();
}

class _ChangeFlyLogoState extends State<ChangeFlyLogo>
    with TickerProviderStateMixin {
  final double size = 200.0;

  AnimationController firstAnimationController;
  AnimationController secondAnimationController;
  AnimationController thirdAnimationController;


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

  //Title section animations
  Animation titleOpacityAnimation;

  //Whole Logo
  Animation opacityAnimation;
  Animation shakeAnimation;

  Curve myCurve = Cubic(0.45, -0.12, 1.0, 0.85);

  @override
  void initState() {
    super.initState();
    firstAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 600));

    firstAnimationController.addListener(() {
      setState(() {});
    });

    firstAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        secondAnimationController.forward(from: 0.0);
      } else if (status == AnimationStatus.forward) {
        thirdAnimationController.value = 0.0;
      }
    });

    secondAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 100));

    secondAnimationController.addListener(() {
      setState(() {});
    });

    secondAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        secondAnimationController.reverse(from: 1.0);
        thirdAnimationController.forward(from: 0.0);
      }
    });

    thirdAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 300));
    thirdAnimationController.addListener(() {
      setState(() {});
    });
    thirdAnimationController.value = 0.0;

    //Top section animations
    topTranslateAnim =
        new Tween(begin: const Offset(0.0, -280.0), end: const Offset(0.0, 0.0))
            .animate(new CurvedAnimation(
            parent: firstAnimationController, curve: myCurve));

    //Left section animations
    leftScaleAnim = new Tween(begin: 3.0, end: 1.0).animate(new CurvedAnimation(
        parent: firstAnimationController, curve: Curves.ease));

    leftTranslateAnim =
        new Tween(begin: const Offset(-80.0, 80.0), end: Offset.zero).animate(
            new CurvedAnimation(
                parent: firstAnimationController, curve: myCurve));

    leftRotationXAnim = new Tween(begin: 1.2, end: 0.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.linear));

    leftRotationYAnim = new Tween(begin: 0.3, end: 0.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.linear));

    //Right section animations
    rightScaleAnim = new Tween(begin: 3.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.ease));

    rightTranslateAnim =
        new Tween(begin: const Offset(80.0, 80.0), end: Offset.zero).animate(
            new CurvedAnimation(
                parent: firstAnimationController, curve: myCurve));

    rightRotationXAnim = new Tween(begin: -1.2, end: 0.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.linear));

    rightRotationYAnim = new Tween(begin: 0.3, end: 0.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.linear));

    //Title section animations
    titleOpacityAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: thirdAnimationController, curve: Curves.linear));

    //Whole View
    opacityAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: firstAnimationController, curve: Curves.linear));

    shakeAnimation = new Tween(begin: 1.0, end: 1.05).animate(
        new CurvedAnimation(
            parent: secondAnimationController, curve: Curves.fastOutSlowIn));

    firstAnimationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        firstAnimationController.forward(from: 0.0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: Transform.scale(
              scale: shakeAnimation.value,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Stack(
                  children: <Widget>[
                    Transform(
                      transform: Matrix4.identity()
                        ..translate(
                            topTranslateAnim.value.dx,
                            topTranslateAnim.value.dy),
                      child: Image.asset(
                          "assets/images/logo/changefly-cube-top.png"),
                    ),
                    Transform(
                      alignment: Alignment(-0.75, 0.1),
                      transform: Matrix4.identity()
                        ..translate(
                            leftTranslateAnim.value.dx,
                            leftTranslateAnim.value.dy)
                        ..scale(leftScaleAnim.value)
                        ..rotateX(leftRotationXAnim.value)
                        ..rotateY(leftRotationYAnim.value),
                      child:
                      Image.asset("assets/images/logo/changefly-cube-left.png"),
                    ),
                    Transform(
                      alignment: Alignment(0.75, 0.1),
                      transform: Matrix4.identity()
                        ..translate(
                            rightTranslateAnim.value.dx,
                            rightTranslateAnim.value.dx)
                        ..scale(rightScaleAnim.value)
                        ..rotateX(rightRotationXAnim.value)
                        ..rotateY(rightRotationYAnim.value),
                      child:
                      Image.asset(
                          "assets/images/logo/changefly-cube-right.png"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Opacity(
            opacity: titleOpacityAnimation.value,
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
    firstAnimationController.dispose();
    secondAnimationController.dispose();
  }
}

class MyCurve extends Curve {
  const MyCurve([this.period = 0.4]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    final double s = 0.1;
    t = t - 1.0;
    return -math.pow(2.0, 10.0 * t) *
        math.sin((t - s) * (math.pi * 2.0) / period);
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(t * math.pi * 2);
  }
}
