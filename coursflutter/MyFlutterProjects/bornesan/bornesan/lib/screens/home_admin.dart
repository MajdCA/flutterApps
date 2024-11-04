import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> userDataList = [];

  TextEditingController maxAuthorizedController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Input form for adding data
            Card(
              elevation: 5,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: maxAuthorizedController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Max Authorized'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _addData();
                      },
                      child: Text('Add Data'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _pickDate();
                      },
                      child: Text('Pick Date'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selected Date: ${selectedDate.toLocal()}',
                    ),
                  ],
                ),
              ),
            ),
            // Display user data
            userDataList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      Timestamp timestamp = userDataList[index]['date'];
                      DateTime dateTime = timestamp.toDate();
                      int realAuthorised =
                          userDataList[index]['realAuthorised'];
                      int maximumAuthorised =
                          userDataList[index]['maximumAuthorised'];
                      return Card(
                        child: ListTile(
                          title: Text(
                              'Data for user with ID ${FirebaseAuth.instance.currentUser?.uid}:'),
                          subtitle: Text(
                            ' Real Authorised : $realAuthorised \n Date: $dateTime\n MaximumAuthorised: $maximumAuthorised',
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            // Chart
            Container(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: const Legend(
                    isVisible: true), // Add this line to enable the legend
                series: <ChartSeries>[
                  // Renders bar chart
                  BarSeries<Map<String, dynamic>, String>(
                    name: 'Maximum Authorised', // Add a name for the series
                    dataSource: userDataList,
                    xValueMapper: (data, _) =>
                        'Date: ${data['date'].toDate().day}/${data['date'].toDate().month}',
                    yValueMapper: (data, _) => data['maximumAuthorised'],
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  BarSeries<Map<String, dynamic>, String>(
                    name: 'Real Authorised', // Add a name for the series
                    dataSource: userDataList,
                    xValueMapper: (data, _) =>
                        'Date: ${data['date'].toDate().day}/${data['date'].toDate().month}',
                    yValueMapper: (data, _) => data['realAuthorised'],
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        int maxAuthorized = int.parse(maxAuthorizedController.text);

        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot userDocument = await usersCollection.doc(uid).get();

        if (userDocument.exists) {
          CollectionReference userDataCollection =
              userDocument.reference.collection('userData');

          await userDataCollection.add({
            'date': Timestamp.fromDate(selectedDate),
            'realAuthorised': 0, // You can set this to the actual value
            'maximumAuthorised': maxAuthorized,
          });

          // Refresh the displayed user data
          _displayUserData();
        } else {
          print('User document not found for user with ID $uid.');
        }
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error adding user data: $e');
    }
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _displayUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
        DocumentSnapshot userDocument = await usersCollection.doc(uid).get();

        if (userDocument.exists) {
          CollectionReference userDataCollection =
              userDocument.reference.collection('userData');
          QuerySnapshot userDataSnapshot = await userDataCollection.get();

          if (userDataSnapshot.size > 0) {
            List<Map<String, dynamic>> dataList = [];
            userDataSnapshot.docs.forEach((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              dataList.add(data);
            });

            setState(() {
              userDataList = dataList;
            });
          } else {
            print(
                'No data found in the userData subcollection for user with ID $uid.');
          }
        } else {
          print('User document not found for user with ID $uid.');
        }
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    print("Signed Out");
  }

  @override
  void initState() {
    super.initState();
    _displayUserData();
  }
}
