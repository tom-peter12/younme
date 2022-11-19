import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'Login/login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  Future<void> _startApp() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    if (token == null) {
      print("token is null ");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
      // TODO Navigate to Login Screen
    } else {
      print("Token is available");
      // TODO Navigate to Home 
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splashscreen"),
      ),
    );
  }
}
