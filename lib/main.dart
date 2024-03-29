import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIMER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _inputHours;
  late int _inputMinutes;
  late int _inputSeconds;
  late Duration _duration;
  late Timer _timer;
  bool _isPaused = false;
  bool _isTimeUp = false; 
  bool _isStarted = false; 

  @override
  void initState() {
    super.initState();
    _inputHours = 0;
    _inputMinutes = 0;
    _inputSeconds = 0;
    _duration = Duration(seconds: 0);
  }

  void _startCountdown() {
    int totalTimeInSeconds = (_inputHours*3600) + (_inputMinutes*60) + _inputSeconds;
    if (totalTimeInSeconds > 0) {
      _duration = Duration(seconds: totalTimeInSeconds);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!_isPaused) {
          setState(() {
            if (_duration.inSeconds > 0) {
              _duration -= Duration(seconds: 1);
            } else {
              _timer.cancel();
              _isTimeUp = true; 
            }
          });
        }
      });
      _isStarted = true; 
    }
  }

  void _pauseCountdown() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeCountdown() {
    setState(() {
      _isPaused = false;
    });
  }

  void _resetCountdown() {
    _timer.cancel();
    setState(() {
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false; 
      _isStarted = false; 
    });
  }

  void _restartCountdown() {
    setState(() {
      _inputHours = 0;
      _inputMinutes = 0;
      _inputSeconds = 0;
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false;
      _isStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              'TIMER',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                SizedBox(width: 5),
                Text(
                  'Adinda Yecinthya Nurliyanti - 222410102025',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ]
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : <Widget>[
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Hours'),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      setState(() {
                        _inputHours = int.tryParse(value) ?? 0;
                      });
                    }
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Minutes'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _inputMinutes = int.tryParse(value) ?? 0;
                      });
                    }
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Seconds'),
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      setState(() {
                        _inputSeconds = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                )
              ]
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isStarted ? null : _startCountdown,
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 9, 185, 118),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      _isTimeUp
                          ? 'Time is Up!'
                          : '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: _isTimeUp ? 20 : 48,
                        color: _isTimeUp ? Colors.red : Color.fromARGB(255, 20, 4, 255),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_isTimeUp)
                      ElevatedButton(
                        onPressed: _restartCountdown,
                        child: Text('Restart'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 9, 185, 118),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _isPaused ? _resumeCountdown : _pauseCountdown,
                            child: Text(_isPaused ? 'Resume' : 'Pause'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 21, 158, 140),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _resetCountdown,
                            child: Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 11, 94, 143),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
