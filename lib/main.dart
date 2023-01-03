import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopWatchPage(),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  var _isPlaying = false;
  var _isFinished = false;
  var _icon = Icons.play_arrow;
  var _time = 0;
  var _grade = '';
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stop watch'),
        ),
        body: Column(
          children: [
            _body(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: FloatingActionButton(
                    onPressed: () => setState(() {
                      _click();
                    }),
                    child: Icon(_icon),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  width: 100,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () => setState(() {
                      _click2();
                    }),
                    child: Icon(Icons.disabled_by_default_outlined),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget _body() {
    var sec = _time ~/ 100;
    var mill = '${_time % 100}'.padLeft(2, '0');
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isFinished
                  ? RichText(
                      text: TextSpan(
                      text: '$sec' + '.',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: '$mill',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15,
                              color: Colors.grey,
                            ))
                      ],
                    ))
                  : Text(
                      _isPlaying ? '$_grade' : 'stop',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
          SizedBox(height: 280),
        ],
      ),
    );
  }

  void _click() {
    _isPlaying = !_isPlaying;
    if (_isFinished) {
      _time = 0;
    }
    _isFinished = false;

    if (_isPlaying == true) {
      _icon = Icons.pause;
      _start();
    } else {
      _icon = Icons.play_arrow;
      _stop();
    }
    print("clicked");
  }

  void _click2() {
    _isPlaying = !_isPlaying;
    _stop();
    _isFinished = true;
    _icon = Icons.play_arrow;
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
        setGrade();
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  void setGrade() {
    if (_time < 300) {
      _grade = 'F';
    } else if (_time < 600) {
      _grade = 'D';
    } else if (_time < 900) {
      _grade = 'C';
    } else if (_time < 1200) {
      _grade = 'B';
    } else if (_time < 1500) {
      _grade = 'A';
    }
  }
}
