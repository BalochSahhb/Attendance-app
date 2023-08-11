import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController leaveApplicationController = TextEditingController();

  bool applicationSubmitted = false;

  @override
  void initState() {
    super.initState();
    // Check if the current user has already submitted an application
    checkApplicationStatus();
  }

  void checkApplicationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('application')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      setState(() {
        applicationSubmitted = snapshot.docs.isNotEmpty;
      });
    }
  }

  void submitApplication() async {
    String name = nameController.text;
    String studyField = studyFieldController.text;
    String id = idController.text;
    String leaveApplication = leaveApplicationController.text;

    // Check if the student has already submitted an application
    if (applicationSubmitted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have already submitted an application.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check if any of the fields are empty
    if (name.isEmpty || studyField.isEmpty || id.isEmpty || leaveApplication.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Save the data to Firebase
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Map<String, dynamic> applicationData = {
        'userId': currentUser.uid,
        'name': name,
        'studyField': studyField,
        'id': id,
        'leaveApplication': leaveApplication,
        'status': 'Pending', // Set the initial status to "Pending"
      };

      FirebaseFirestore.instance
          .collection('application')
          .add(applicationData)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your application submitted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          applicationSubmitted = true;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit application. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    // Clear the text fields after submission
    nameController.clear();
    studyFieldController.clear();
    idController.clear();
    leaveApplicationController.clear();
  }

  void deleteApplication(String docId) async {
    await FirebaseFirestore.instance.collection('application').doc(docId).delete();
    setState(() {
      applicationSubmitted = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application deleted successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Application'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Internee Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: studyFieldController,
                decoration: InputDecoration(
                  labelText: 'Internee Field',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Internee ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: leaveApplicationController,
                decoration: InputDecoration(
                  labelText: 'Leave Application',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, // Make the text field multiline
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: applicationSubmitted ? null : submitApplication,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              // StreamBuilder to display submitted applications
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('application')
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
                      Text(
                        'Your submitted applications:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          final doc = data.docs[index];
                          final applicationName = doc['name'];
                          final applicationField = doc['studyField'];
                          final applicationId = doc['id'];
                          final application = doc['leaveApplication'];
                          final status = doc['status'];
                          final docId = doc.id;

                          return Card(
                            child: ListTile(
                              title: Text('Name: $applicationName'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Field: $applicationField'),
                                  Text('ID: $applicationId'),
                                  Text('Leave Application: $application'),
                                  Text('Status: $status'),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => deleteApplication(docId),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
