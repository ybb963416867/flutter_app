import 'package:flutter/material.dart';
import "package:english_words/english_words.dart";

void main() => runApp(new MaterialApp(
      title: 'my app',
      home: new MyScaffold(),
    ));

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(
            child: new Container(
              constraints: new BoxConstraints.expand(
                height:Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
              ),
              decoration: new BoxDecoration(
                border: new Border.all(width: 2.0, color: Colors.red),
                color: Colors.grey,
                borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                image: new DecorationImage(
                  image: new NetworkImage('http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg'),
                  centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                ),
              ),
              padding: const EdgeInsets.all(28.0),
              alignment: Alignment.center,
              child: new Text('Hello World',
                  style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black)),
              transform: new Matrix4.rotationZ(0),
            ),
          )
        ],
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text('Count: $count');
  }
}

class CounterIncrement extends StatelessWidget {
  CounterIncrement({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return new Row(
//      children: <Widget>[
//        new RaisedButton(
//          onPressed: _increment,
//          child: new Text('Increment'),
//        ),
//        new Text('Count: $_counter'),
//      ],
//    );
  return new Row(
    children: <Widget>[
      new  CounterIncrement(onPressed: _increment,),
      new  CounterDisplay(count: _counter,),
    ],
  );
  }
}



class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: () {
        print("点击了");
      },
      onLongPressMoveUpdate: (aa) {
        print("x:" +
            aa.localPosition.dx.toString() +
            "" +
            aa.localPosition.dy.toString());
      },
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.menu),
                tooltip: 'Navigation menu',
                onPressed: aa),
            new Expanded(child: title)
          ],
        ),
      ),
    );
  }

  void aa() {
    print("yangbinbing");
  }
}
