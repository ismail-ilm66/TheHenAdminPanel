import 'dart:convert';
import 'package:http/http.dart' as http;
import 'service_account_service.dart';

/// Sends a notification to a single user or device using their FCM token
Future<void> sendNotification(String token, String title, String body) async {
  const String fcmUrl = 'https://fcm.googleapis.com/v1/projects/joyufulapp/messages:send';
  final String accessToken = await getAccessToken();

  try {
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "message": body,
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error sending notification: $e');
  }
}