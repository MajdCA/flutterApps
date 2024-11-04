import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterfire_ui/auth.dart';
import 'firestoreUserData.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late String imageUrl = ''; // URL of the retrieved image

  @override
  void initState() {
    super.initState();
    getImageUrlFromFirebase();
  }

  Future<void> getImageUrlFromFirebase() async {
    String imagePath =
        'BEAUTY-LANDSCAPE-LAKE-1192023.png'; // Replace with the actual path to your image in Firebase Storage
    Reference ref = FirebaseStorage.instance.ref().child(imagePath);

    try {
      final String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error retrieving image from Firebase Storage: $e');
      setState(() {
        imageUrl = ''; // Set imageUrl to an empty string on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl) // Display the image from the retrieved URL
                : const Text('No image available'),
            const Text(
              'Welcome! USER XD ',
              style: TextStyle(fontSize: 18),
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
