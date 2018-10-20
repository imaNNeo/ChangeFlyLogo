import 'package:change_fly_logo/sample1/sample1.dart';
import 'package:flutter/material.dart';

class Sample1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sample 1"),),
      body: Center(
        child: Sample1(),
      ),
    );
  }

}