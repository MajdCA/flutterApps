import 'package:flutter/material.dart';

void main() => runApp(const MyWidget());

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.access_alarm),
          title: const Text('majd saidani xd'),
          elevation: 4,
        ),
        body: const InteractiveWidget(),
      ),
    );
  }
}

class InteractiveWidget extends StatefulWidget {
  const InteractiveWidget({super.key});

  @override
  State<InteractiveWidget> createState() => _InteractiveWidgetState();
}

class _InteractiveWidgetState extends State<InteractiveWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Icon(
              Icons.add,
              size: 50.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: 60, color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: _decrementCounter,
            child: const Icon(
              Icons.remove,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
