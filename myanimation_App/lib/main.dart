import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        controller.reverse();
      else if (status == AnimationStatus.dismissed) controller.fling();
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: AnimatedLogo(animation: animation),
        ),
        Text('LOADING')
      ],
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _sizeAnime = Tween<double>(begin: 50.0, end: 100.0);
  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
        opacity: animation.value,
        child: Transform.rotate(
          angle: _sizeAnime.evaluate(animation),
          child: Container(
            height: 200,
            width: 200,
            child: Image.network(
                'https://github.com/pubgplayer/fluttertry/blob/master/istockphoto-1226522716-170667a.jpg?raw=true'),
          ),
        ));
  }
}
