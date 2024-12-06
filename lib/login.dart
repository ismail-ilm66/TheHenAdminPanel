import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'colors.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isObscured = true;
  final bool res = false;

  void _login(BuildContext context) {
    if (_usernameController.text == 'admin' &&
        _passwordController.text == 'admin1@') {
      Get.off(() => DashboardScreen(),
          transition: Transition.fadeIn, duration: Duration(milliseconds: 500));
    } else {
      Get.snackbar(
        "Error",
        "Invalid credentials",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        animationDuration: Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorPalette.primaryColor.withOpacity(0.7),
              ColorPalette.primaryColor.withOpacity(0.9),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Admin Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: -0.5, end: 0),
                SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  focusNode: _usernameFocus,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon:
                        Icon(Icons.person, color: ColorPalette.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ColorPalette.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: ColorPalette.primaryColor, width: 2),
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon:
                        Icon(Icons.lock, color: ColorPalette.primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: ColorPalette.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ColorPalette.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: ColorPalette.primaryColor, width: 2),
                    ),
                  ),
                ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.1, end: 0),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => _login(context),
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text("Login", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 700.ms)
                    .scale(begin: Offset(0.5, 0.5), end: Offset(1, 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
