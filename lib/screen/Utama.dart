import 'package:flutter/material.dart';
import 'package:starwarsapk/screen/pplist.dart';

class Homeku extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Mainku(),
    );
  }
}


class Mainku extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Pplist();
  }
}
