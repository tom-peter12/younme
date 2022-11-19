// import 'package:flutter/material.dart';
// import 'package:chatter/background.dart';
// import 'components/sign_up_top_image.dart';
// import 'components/signup_form.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Background(
//       child: SingleChildScrollView(
//         child: MobileSignupScreen(),
//       ),
//     );
//   }
// }

// class MobileSignupScreen extends StatelessWidget {
//   const MobileSignupScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const SignUpScreenTopImage(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: SignUpForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//         // const SocalSignUp()
//       ],
//     );
//   }
// }






import 'dart:convert';

import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../widgets/text_field_input.dart';
import '../Login/login_screen.dart';
import '../home_screen.dart';
import '../utils/address.dart';

final storage = FlutterSecureStorage();
// import 'package:smart_lock/screens/login_screen.dart';
// import 'package:smart_lock/utils/colors.dart';
// import 'package:smart_lock/widgets/text_field_input.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:my_app/utils/colors.dart';
// import 'package:my_app/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SharedPreferences sharedPreferences;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController LnameController = TextEditingController();
  bool error = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    LnameController.dispose();
    nameController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("suii");
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
              SvgPicture.asset(
                "Assets/lg.svg",
                color: Colors.redAccent,
                height: 70,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldInput(
                hintText: "Enter your Name",
                textInputType: TextInputType.text,
                textEditingController: nameController,
              ),
              SizedBox(
                height: 12,
              ),
              TextFieldInput(
                hintText: "Enter your Last Name",
                textInputType: TextInputType.text,
                textEditingController: LnameController,
              ),
              SizedBox(
                height: 12,
              ),
              TextFieldInput(
                hintText: "Enter username",
                textInputType: TextInputType.text,
                textEditingController: usernameController,
              ),
              SizedBox(
                height: 12,
              ),

              // email input
              TextFieldInput(
                hintText: "Enter your number",
                textInputType: TextInputType.emailAddress,
                textEditingController: emailController,
              ),
              SizedBox(
                height: 12,
              ),
              // password input
              TextFieldInput(
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                textEditingController: passController,
                isPass: true,
              ),
              SizedBox(
                height: 36,
              ),
              InkWell(
                onTap: () {
                  signUp(
                    emailController.text,
                    passController.text,
                    LnameController.text,
                    nameController.text,
                    usernameController.text,
                  );
                },
                child: Container(
                  child: const Text("Sign Up"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.red),
                ),
              ),
              SizedBox(
                height: 12,
              ),

              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Do you have an account? ",
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
                          builder: (context) => LoginScreen(),
                        ),
                      );
                      // ignore: avoid_print
                      // print("tapped");
                    },
                    child: Container(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.secondary),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
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

  void signUp(
    emailController,
    passController,
    LnameController,
    nameController,
    usernameController,
  ) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var data = """{
  "username": \"""" +
        usernameController +
        """\",
  "password_hash": \"""" +
        passController +
        """\",
  "name": \"""" +
        nameController +
        """\",
  "lName": \"""" +
        LnameController +
        """\",
  "phone_number": \"""" +
        emailController +
        """\",
  "public_key": "string"
}""";

    var url = Uri.parse(ADDRESS+ 'register');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200) {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
    print(res.body);
    if (res.statusCode == 200) {
      setState(() {
        error = false;
      });
      logIn(usernameController, passController);
    } else {
      setState(() {
        error = true;
      });
    }
  }

  logIn(String username, String password) async {
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

    var url = Uri.parse(ADDRESS+ 'token');

    var res = await http.post(url, headers: headers, body: data);

    sharedPreferences = await SharedPreferences.getInstance();

    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      await storage.delete(key: "token");

      await storage.write(key: "token", value: jsonData['access_token']);

      print("there is a response ");
      print("there is a response ");
      print("there is a response ");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
    ;
  }

  void profile() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("access_token") == null) {
      print("it is null bruh!");

// you need to reroute the user to the login page

    }

    String? token = sharedPreferences.getString("access_token");
    var headers = {
      'accept': 'application/json',
      'Authorization': "Bearer " + token!,
    };

    var url = Uri.parse(ADDRESS+ 'profile');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print("Right here, right here!\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    print(res.body);
  }
}

