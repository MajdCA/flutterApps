import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('icons on text field xd'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                      width: 300,
                      child: const TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 3)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 3)),
                            border: OutlineInputBorder(),
                            labelText: "Nom d'utilisateur",
                            hintText: "Nom d'utilisateur",
                            prefixIcon: Icon(Icons.person)),
                        autofocus: false,
                      )),
                  Container(
                      margin: EdgeInsets.all(8),
                      width: 300,
                      child: const TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 3)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 3)),
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe',
                            hintText: 'Mot de passe',
                            prefixIcon: Icon(Icons.lock)),
                        obscureText: true,
                        autofocus: false,
                      ))
                ]))));
  }
}
