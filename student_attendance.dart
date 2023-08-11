import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Attendance App',
      home: StudentAttendance(),
    );
  }
}

class StudentAttendance extends StatefulWidget {
  const StudentAttendance({Key? key}) : super(key: key);

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  bool _showLeavingApplications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15,),
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: '',
                          ),
                        ),
                        SizedBox(width: 55,),
                        Text(
                          'Field',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: '',
                          ),
                        ),
                        SizedBox(width: 60,),
                        Text(
                          'Id',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: '',
                          ),
                        ),
                        SizedBox(width: 70,),
                        Text(
                          'Action',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 40.0, top: 18),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      documentSnapshot["interneeName"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Victor',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      documentSnapshot["interneeField"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Victor',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      documentSnapshot["interneeId"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Victor',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        // Remove from Firebase
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(documentSnapshot.id)
                                            .delete();
                                        // If successful, show a snackbar message
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('User deleted successfully.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } catch (e) {
                                        // If there's an error, show a snackbar with the error message
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Error: $e'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _showLeavingApplications ? 60 : 0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeavingApplicationsPage()),
                );
              },
              child: Text('View Leaving Applications'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showLeavingApplications = !_showLeavingApplications;
          });
        },
        child: Icon(_showLeavingApplications ? Icons.arrow_downward : Icons.arrow_upward),
      ),
    );
  }
}

class LeavingApplicationsPage extends StatefulWidget {
  @override
  _LeavingApplicationsPageState createState() => _LeavingApplicationsPageState();
}

class _LeavingApplicationsPageState extends State<LeavingApplicationsPage> {
  // Function to accept the leave application
  void acceptLeaveApplication(String docId) {
    FirebaseFirestore.instance.collection('application').doc(docId).update({'status': 'Accepted'}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Application Accepted.'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept application.'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  // Function to reject the leave application
  void rejectLeaveApplication(String docId) {
    FirebaseFirestore.instance.collection('application').doc(docId).update({'status': 'Rejected'}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Application Rejected.'),
          backgroundColor: Colors.red,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to reject application.'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaving Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('application').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final data = snapshot.data;
          if (data == null || data.docs.isEmpty) {
            return Center(
              child: Text('No leaving applications found.'),
            );
          }

          return ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              final doc = data.docs[index];
              final name = doc['name'];
              final studyField = doc['studyField'];
              final id = doc['id'];
              final leaveApplication = doc['leaveApplication'];
              final status = doc['status'];

              return ListTile(
                title: Text('$name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text('$studyField'),
                    SizedBox(height: 10),
                    Text('$id'),
                    SizedBox(height: 10),
                    Text('Leave Application: $leaveApplication', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Status: $status', style: TextStyle(fontWeight: FontWeight.bold, color: status == 'Accepted' ? Colors.green : Colors.red)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            acceptLeaveApplication(doc.id);
                          },
                          child: Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            rejectLeaveApplication(doc.id);
                          },
                          child: Text('Reject'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
