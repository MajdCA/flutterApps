import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*class Userlist extends StatelessWidget {
  const Userlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<Widget> userWidgets = [];
        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          // Check if 'userName', 'email', and 'role' are not null before accessing them
          if (data['userName'] != null &&
              data['email'] != null &&
              data['role'] != null) {
            Widget userWidget = ListTile(
              title: Text(data['userName']),
              subtitle: Text('Email: ${data['email']}, Role: ${data['role']}'),
            );

            userWidgets.add(userWidget);
          }
        }

        return ListView(
          children: userWidgets,
        );
      },
    );
  }
}*/

class Userlist extends StatefulWidget {
  const Userlist({super.key});

  @override
  State<Userlist> createState() => UserlistState();
}

class UserlistState extends State<Userlist> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> deleteUser(String userId) async {
    // 1. Delete the user from Firebase Authentication
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        // Check if the user to be deleted is the currently signed-in user
        if (user.uid == userId) {
          // Sign out the user if trying to delete the signed-in user
          await _auth.signOut();
          // Set user.uid to userId if they are not the same
          await user.delete();
        }
      }

      // 2. Delete the user's data from Firestore
      await usersCollection.doc(userId).delete();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final users = snapshot.data?.docs;

          return DataTable(
            columns: const [
              DataColumn(label: Text('email')),
              DataColumn(label: Text('role')),
              DataColumn(label: Text('userName')),
              DataColumn(label: Text('Actions')),
            ],
            rows: users!.map((userDocument) {
              final user = userDocument.data() as Map<String, dynamic>;
              final userId = userDocument.id;

              return DataRow(
                cells: [
                  DataCell(Text(user['email'])),
                  DataCell(Text(user['role'])),
                  DataCell(Text(user['userName'])),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete this account?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Return'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () async {
                                    await deleteUser(userId);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
