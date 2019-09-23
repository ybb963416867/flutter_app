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
            child: new Counter(),
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
      new  CounterDisplay(count: _counter,)
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
