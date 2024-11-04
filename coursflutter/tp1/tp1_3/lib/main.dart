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
          leading: const Icon(Icons.thumbs_up_down),
          title: const Text('majd again xD'),
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
              Icons.thumb_up,
              size: 50.0,
              color: Colors.blue,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: 60, color: Colors.blue),
            ),
          ),
          ElevatedButton(
            onPressed: _decrementCounter,
            child: const Icon(
              Icons.thumb_down,
              size: 50.0,
              color: Colors.red,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
