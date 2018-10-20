import 'package:flutter/material.dart';
import 'changeflylogo.dart';
import 'samplespage.dart';

void main() => runApp(new MaterialApp(
  home: HomePage(),
));

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ChangeFlyLogo(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text("Click on logo to animate", style: TextStyle(color: Colors.purple, fontSize: 24.0, fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) { return new SamplesPages();}));
                }, child: Text('My Alternative Samples', style: TextStyle(color: Colors.purple),),),
              ),
            )
          ],
        ),
      ),
    );
  }

}