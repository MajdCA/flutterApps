import 'package:cloud_firestore/cloud_firestore.dart';

class TestFirestoreAccess {
  void testFirestoreAccess(String userId) {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    usersCollection.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        // Access the document data here

        checkIfAdmin(userId).then((bool isAdmin) {
          if (isAdmin) {
            print('User is an admin');
          } else {
            print('User is not an admin');
          }
        });
      } else {
        print('Document does not exist');
      }
    }).catchError((e) {
      print('Error accessing Firestore: $e');
    });
  }

  Future<bool> checkIfAdmin(String userId) async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      bool isAdmin = data['isAdmin'] ?? false;
      return isAdmin;
    } else {
      return false;
    }
  }
}
