import 'package:flutter/material.dart';
import 'changeflylogo.dart';

void main() => runApp(new MaterialApp(
  home: HomePage(),
));

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ChangeFlyLogo()),
    );
  }

}