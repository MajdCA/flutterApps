import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            width: 100,
            height: 300,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: const CircleBorder(
                        side: BorderSide(width: 20, color: Colors.blue)) +
                    const CircleBorder(
                        side: BorderSide(
                            width: 20,
                            color: Color.fromRGBO(167, 211, 97, 1))) +
                    const CircleBorder(
                        side: BorderSide(width: 20, color: Color(0xFF7F4CAF))) +
                    const CircleBorder(
                        side: BorderSide(
                            width: 20,
                            color: Color.fromARGB(255, 224, 205, 26)))),
            child: const Center(
                child: Text("ok", style: TextStyle(fontSize: 50)))));
  }
}
