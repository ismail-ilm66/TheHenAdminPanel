import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    String usernames = _usernameController.text.trim();
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (usernames.isEmpty || title.isEmpty || description.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      List<String> usernameList = usernames.split(',').map((username) => username.trim()).toList();

      for (var username in usernameList) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(username).get();

        if (userDoc.exists) {
          String token = userDoc['fcm_token'];
          await sendNotification(token, title, description);

          Get.snackbar(
            "Success",
            "Notification sent to $username!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            "User $username not found",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      }

      _titleController.clear();
      _descriptionController.clear();
      _usernameController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send notification: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<int> _getTotalUsersCount() async {
    try {
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();
      return usersSnapshot.size;
    } catch (e) {
      print("Error fetching user count: $e");
      return 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorPalette.primaryColor,
        elevation: 0,
        actions: [
/*          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Get.back(),
          )*/
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNotificationCard().animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.2, end: 0),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder<int>(
                      future: _getTotalUsersCount(),  // Fetching the total user count from Firestore
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While waiting for the data, show a loading state
                          return _buildQuickStatCard(
                            title: "Total Users",
                            value: "Loading...",  // Show loading state
                            icon: Icons.people,
                            color: Colors.blue,
                          );
                        } else if (snapshot.hasError) {
                          return _buildQuickStatCard(
                            title: "Total Users",
                            value: "Error",
                            icon: Icons.error,
                            color: Colors.red,
                          );
                        } else if (snapshot.hasData) {
                          int totalUsers = snapshot.data ?? 0;
                          return _buildQuickStatCard(
                            title: "Total Users",
                            value: totalUsers.toString(),
                            icon: Icons.people,
                            color: Colors.blue,
                          );
                        } else {
                          return _buildQuickStatCard(
                            title: "Total Users",
                            value: "0",
                            icon: Icons.people,
                            color: Colors.blue,
                          );
                        }
                      },
                    ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
                  ),

                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Notification Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _sendNotificationToAll,
                    icon: Icon(Icons.notifications_active, color: Colors.white),
                    label: Text("Send to All Users", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _sendNotificationToSpecificUser,
                    icon: Icon(Icons.person_search, color: Colors.white),
                    label: Text("Send to Specific User", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

