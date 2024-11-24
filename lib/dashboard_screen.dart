import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordpress_admin/send_notification_service.dart';

import 'colors.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void _sendNotificationToAll() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in both Title and Description",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      QuerySnapshot users = await _firestore.collection('users').get();

      for (var user in users.docs) {
        String token = user['fcm_token'];
        await sendNotification(token, title, description);
      }

      Get.snackbar(
        "Success",
        "Notification sent to all users!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      _titleController.clear();
      _descriptionController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send notifications: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void _sendNotificationToSpecificUser() async {
    String username = _usernameController.text.trim();
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (username.isEmpty || title.isEmpty || description.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(username).get();

      if (userDoc.exists) {
        String token = userDoc['fcm_token'];
        await sendNotification(token, title, description);

        Get.snackbar(
          "Success",
          "Notification sent to $username!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        _titleController.clear();
        _descriptionController.clear();
        _usernameController.clear();
      } else {
        Get.snackbar(
          "Error",
          "User not found",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send notification: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send Notifications",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Notification Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Notification Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sendNotificationToAll,
              icon: Icon(Icons.notifications_active, color: Colors.black,),
              label: Text("Send to All Users", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _sendNotificationToSpecificUser,
              icon: Icon(Icons.person_search, color: Colors.black,),
              label: Text("Send to Specific User", style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
