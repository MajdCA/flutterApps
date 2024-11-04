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
          leading: const Icon(Icons.grid_view),
          title: const Text('Majd saidani xD'),
          elevation: 4,
          backgroundColor: Colors.green,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Icon(
              Icons.arrow_upward,
              size: 50.0,
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: 60, color: Colors.green),
            ),
          ),
          ElevatedButton(
            onPressed: _decrementCounter,
            child: const Icon(
              Icons.arrow_downward,
              size: 50.0,
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
        ],
      ),
    );
  }
}
