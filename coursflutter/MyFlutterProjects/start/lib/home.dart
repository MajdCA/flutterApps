import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'firestoreUserData.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //CHECK IF ADMIN TESTING
    TestFirestoreAccess testFirestoreAccess = TestFirestoreAccess();
    String userId =
        'ZEDS2bKmaIq0P2IUS9Ce'; // Replace with an actual user ID from your 'users' collection
    testFirestoreAccess.testFirestoreAccess(userId);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Background color
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white, // Icon color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<ProfileScreen>(
                      builder: (context) => ProfileScreen(
                        appBar: AppBar(
                          title: const Text('User Profile'),
                        ),
                        actions: [
                          SignedOutAction((context) {
                            Navigator.of(context).pop();
                          })
                        ],
                      ),
                    ),
                  );
                },
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('dash.png'),
            Text(
              'Welcome! ADMIN',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
