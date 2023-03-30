import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  late Timer _timer;
  int _timeCount = 0;
  bool _isRunning = false;
  List<String> _lapTimeList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('스톱워치'),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        onPressed: () => setState(() {
          _clickPlayButton();
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    int secondCount = _timeCount ~/ 100;
    String hundredthCount = '${_timeCount % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '$secondCount',
                      style: TextStyle(fontSize: 70),
                    ),
                    Text(
                      '.' + '$hundredthCount',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: ListView(
                    children: _lapTimeList
                        .map((time) => Text(
                              time,
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                onPressed: _clickResetButton,
                child: Icon(Icons.restart_alt),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _recordLapTime('$secondCount.$hundredthCount');
                  });
                },
                child: Text('랩타임'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _timeCount++;
      });
    });
  }

  void _pause() {
    _timer.cancel();
  }

  void _clickPlayButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _clickResetButton() {
    setState(() {
      _isRunning = false;
      _timer.cancel();
      _lapTimeList.clear();
      _timeCount = 0;
    });
  }

  void _recordLapTime(String time) {
    _lapTimeList.insert(0, '${_lapTimeList.length + 1}등   $time');
  }
}
