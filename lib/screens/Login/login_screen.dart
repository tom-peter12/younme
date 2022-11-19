// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/text_field_input.dart';
import '../Signup/signup_screen.dart';
import '../home_screen.dart';
import '../utils/address.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



// Create storage
final storage = FlutterSecureStorage();
// import 'package:smart_lock/HTTP/httprequest.dart';
// import 'package:smart_lock/HTTP/oauth2p0.dart';
// import 'package:smart_lock/screens/signup_screen.dart';
// import 'package:smart_lock/utils/colors.dart';
// import 'package:smart_lock/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPreferences;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String r = "Not Logged In";
  bool error = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // authmain();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            // ignore: prefer_const_literals_to_create_immutables
            children: [
              (error)
                  ? Text(
                      "There was an error please try again!",
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    )
                  : Text(""),
              Flexible(child: Container(), flex: 2),
              //SVG image
              // SvgPicture.asset(
              //   'Assets/lg.svg',
              //   color: secondaryColor,
              //   height: 70,
              // ),
              const SizedBox(
                height: 30,
              ),
              // email input
              TextFieldInput(
                hintText: "Enter your username ",
                textInputType: TextInputType.text,
                textEditingController: emailController,
              ),
              const SizedBox(
                height: 12,
              ),
              // password input
              TextFieldInput(
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                textEditingController: passController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  // ignore: avoid_print

                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => SignUpScreen(),
                  //   ),
                  // ),
                  // ignore: avoid_print
                  postRequest(emailController.text, passController.text);
                },
                child: Container(
                  child: const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.redAccent),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      "You don't have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: AppColors.secondary),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ignore: avoid_print

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                      // ignore: avoid_print
                      // print("tapped");
                    },
                    child: Container(
                      child: Text(
                        "Sign Up.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.secondary),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )

              // button
              // Transitioning to sign up
            ],
          ),
        ),
      ),
    );
  }

  // Future<Map<String, dynamic>>
  postRequest(String username, String password) async {
    // todo - fix baseUrl
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var data = 'grant_type=&username=' +
        username +
        '&password=' +
        password +
        '&scope=&client_id=&client_secret=';

    var url = Uri.parse(ADDRESS+'token');

    var res = await http.post(url, headers: headers, body: data);

    sharedPreferences = await SharedPreferences.getInstance();

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      await storage.delete(key: "token");

      await storage.write(key: "token", value: jsonData['access_token']);
      await storage.write(key: "username", value: jsonData['obj']['username']);
      await storage.write(key: "number", value: jsonData['obj']['phone_number']);

      print("there is a response ");
      print("there is a response ");
      print("there is a response ");

      setState(() {
        print(jsonData['access_token']);
        // await storage.write(key: "token", value: jsonData['access_token']);
        r = "Logged In";
        error = false;
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        error = true;
      });
    }
    ;
  }

//   void profile() async {
//     sharedPreferences = await SharedPreferences.getInstance();

//     if (sharedPreferences.getString("access_token") == null) {
//       print("it is null bruh!");

// // you need to reroute the user to the login page

//     }

//     String? token = sharedPreferences.getString("access_token");
//     var headers = {
//       'accept': 'application/json',
//       'Authorization': "Bearer " + token!,
//     };

//     var url = Uri.parse('http://127.0.0.1:8000/profile');
//     var res = await http.get(url, headers: headers);
//     if (res.statusCode != 200) {
//       throw Exception('http.get error: statusCode= ${res.statusCode}');
//     }
//     print("Right here, right here!\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
//     print(res.body);
//   }
}

// return json.decode(res.body);
