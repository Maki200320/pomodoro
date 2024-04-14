import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoe/widget/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  int _studyTime = 25 * 60; // 25 minutes
  int _shortBreakTime = 5 * 60; // 5 minutes
  int _longBreakTime = 30 * 60; // 30 minutes
  int _currentTime = 25 * 60; // Initially set to study time

  bool _timerRunning = false;
  bool _studyButtonEnabled = true;
  bool _shortBreakButtonEnabled = true;
  bool _longBreakButtonEnabled = true;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer(int duration) {
    setState(() {
      _timerRunning = true;
      _currentTime = duration;
      _studyButtonEnabled = false;
      _shortBreakButtonEnabled = false;
      _longBreakButtonEnabled = false;
    });
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_currentTime == 0) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Time is up!')),
        );
        setState(() {
          _timerRunning = false;
          _studyButtonEnabled = true;
          _shortBreakButtonEnabled = true;
          _longBreakButtonEnabled = true;
        });
      } else {
        setState(() {
          _currentTime--;
        });
      }
    });
  }

  void _toggleTimer() {
    if (_timerRunning) {
      _timer.cancel();
      setState(() {
        _timerRunning = false;
        _studyButtonEnabled = true;
        _shortBreakButtonEnabled = true;
        _longBreakButtonEnabled = true;
      });
    } else {
      _startTimer(_currentTime);
    }
  }

  void _restartTimer() {
    _timer.cancel();
    setState(() {
      _currentTime = _studyTime;
      _studyButtonEnabled = true;
      _shortBreakButtonEnabled = true;
      _longBreakButtonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: Colors.redAccent.shade200,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      width: width / 5,
                      height: 170,
                      child: Container(
                        width: width / 5,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${(_currentTime ~/ 60)}',
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: width / 5,
                      height: 170,
                      child: Container(
                        width: width / 5,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            (_currentTime % 60).toString().padLeft(2, '0'),
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopBorderButton(
                onPressed: ()=> _studyButtonEnabled ?  _startTimer(_studyTime) : null,
                text: "Start Study",
              ),
              TopBorderButton(
                onPressed:() =>  _shortBreakButtonEnabled ? _startTimer(_shortBreakTime) : null,
               text: "Start Short Break",
              ),
              TopBorderButton(
                onPressed: () => _longBreakButtonEnabled ?  _startTimer(_longBreakTime) : null,
                 text: ("Start Long Break"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_timerRunning) {
                        _toggleTimer(); // Pause the timer
                      } else {
                        _startTimer(_currentTime); // Resume the timer
                      }
                    },
                    child: Text(
                      _timerRunning ? 'Pause' : 'Resume',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 90,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _restartTimer,
                    child: const Text(
                      "Restart",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
