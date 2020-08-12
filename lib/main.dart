import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _FlipCard(),
    );
  }
}

class _FlipCard extends StatefulWidget {
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
          counter++;
        });
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme"),
      ),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.005)
              ..rotateY(pi * _animation.value),
            child: GestureDetector(
              onTap: () {
                if (_animationStatus == AnimationStatus.dismissed) {
                  _animationController.forward();
                  print("forward");
                } else {
                  _animationController.reverse();
                  print("reverse");
                }
              },
              child: _animation.value <= 0.5
                  ? Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/euro1_front.jpg'),
                    )
                  : Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/euro1_back.jpg'),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
