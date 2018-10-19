import 'package:flutter/material.dart';

class ChangeFlyLogo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ChangeFlyLogoState();

}

class _ChangeFlyLogoState extends State<ChangeFlyLogo> {

  final double size = 200.0;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          Image.asset("assets/images/logo/changefly-cube-top.png"),
          Image.asset("assets/images/logo/changefly-cube-left.png"),
          Image.asset("assets/images/logo/changefly-cube-right.png"),
        ],
      ),
    );
  }

}