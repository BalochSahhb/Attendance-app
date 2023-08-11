import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'send_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      home: Attendance(),
    );
  }
}

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late String interneeName, interneeField, interneeId;
  bool itemAdded = false; // Flag to track if an item has been added or not

  getInterneeName(name) {
    this.interneeName = name;
  }

  getInerneeField(field) {
    this.interneeField = field;
  }

  getInterneeId(id) {
    this.interneeId = id;
  }

  // Function to check if data exists for the current user
  Future<bool> checkDataExists() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      return snapshot.docs.isNotEmpty;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // Check if data exists for the current user
    checkDataExists().then((dataExists) {
      setState(() {
        itemAdded = dataExists;
      });
    });
  }

  addData() async {
    if (itemAdded) {
      print('Only one item can be added.');
      return; // If an item has already been added, return without adding another.
    }

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc(interneeName);

    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      print('Internee with name $interneeName already exists!');
    } else {
      Map<String, dynamic> internees = {
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'interneeName': interneeName,
        'interneeField': interneeField,
        'interneeId': interneeId
      };

      documentReference.set(internees).whenComplete(() {
        print("$interneeName added to the list");
        setState(() {
          itemAdded =
          true; // Set the flag to true after successfully adding an item.
        });
        _showSuccessMessage(); // Show success message when item is added
      });
    }
  }

  updateData() async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc(interneeName);

    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {

      Map<String, dynamic> internees = {
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'interneeName': interneeName,
        'interneeField': interneeField,
        'interneeId': interneeId
      };

      documentReference.update(internees).whenComplete(() {
        print("$interneeName Updated");
        _showSuccessMessage();
      });
    } else {
      // Show an error message if the item doesn't exist
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$interneeName does not exist..'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  deleteData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc(interneeName);

    documentReference.delete().whenComplete(() {
      print('$interneeName deleted');
    });
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(' $interneeName Your attendance Successfully added  .'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textarea1 = TextEditingController();
    TextEditingController textarea2 = TextEditingController();
    TextEditingController textarea3 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Attendance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: textarea1,
                decoration: InputDecoration(
                  labelText: "Internee Name",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (String name) {
                  getInterneeName(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: textarea2,
                decoration: InputDecoration(
                  labelText: "Internee Field",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (String field) {
                  getInerneeField(field);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: textarea3,
                decoration: InputDecoration(
                  labelText: "Internee Id",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (String id) {
                  getInterneeId(id);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: itemAdded
                      ? null
                      : () {
                    addData();
                    textarea1.clear();
                    textarea2.clear();
                    textarea3.clear();
                  },
                  child: Text('Present'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    updateData();
                    textarea1.clear();
                    textarea2.clear();
                    textarea3.clear();
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    deleteData();
                    textarea1.clear();
                    textarea2.clear();
                    textarea3.clear();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaveApplicationPage()),
                );
              },
              child: Text('Send Leave Application'),
            ),
            // StreamBuilder to display data for the current user only
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final data = snapshot.data;
                if (data == null || data.size == 0) {
                  return SizedBox.shrink();
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Internee Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'YsabeauOffice',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Internee Field',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'YsabeauOffice',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Internee Id',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'YsabeauOffice',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final doc = data.docs[index];
                        final interneeName = doc['interneeName'];
                        final interneeField = doc['interneeField'];
                        final interneeId = doc['interneeId'];

                        return Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  interneeName,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  interneeField,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  interneeId,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
