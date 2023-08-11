import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String imageUrl = "";

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image != null) {
      Reference ref = FirebaseStorage.instance.ref().child("avatar.png");
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        print(value);

        setState(() {
          imageUrl = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('register').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }

          if (snapshot.hasData) {
            final userData = snapshot.data!.data();
            if (userData != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickUploadImage();
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                        child: ClipOval(
                          child: imageUrl.isEmpty
                              ? Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )
                              : Image.network(
                            imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Name: ${userData['name']}'),
                    SizedBox(height: 10),
                    Text('Email: ${userData['email']}'),
                    // Add other profile details if available
                  ],
                ),
              );
            }
          }

          return Center(child: Text('No data found'));
        },
      ),
    );
  }
}
