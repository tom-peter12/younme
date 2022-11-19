import 'dart:convert';

import 'package:chatter/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

import '../../models/contacts_data.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  bool camState = false;
  bool saved = false;
  bool isLoading = false;
  late Contacts contact;

  String? _qrInfo = 'Scan a QR/Bar code';

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: () {
          if (camState == true) {
            setState(() {
              camState = false;
            });
          } else {
            setState(() {
              camState = true;
            });
          }
        },
        child: const Icon(
          Icons.camera,
          color: AppColors.accent,
        ),
      ),
      body: camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code :" + json.decode(_qrInfo!),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
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
                      // saveContact(_qrInfo);
                    },
                    child: Container(
                      child: const Text("Save"),
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
                ],
              ),
            ),
    );
    // print(json.decode(_qrInfo!));
  }

  // void saveContact(String? qrInfo) async{
  //   Future refreshContact() async {
  //     setState(() => isLoading = true);
  //   },


  //   if (res.statusCode == 200) {
  //     var jsonData = jsonDecode(res.body);

      
  //     print("there is a response ");
  //     print("there is a response ");
  //     print("there is a response ");

  //     setState(() {
        
  //       saved = true;
  //     });

   
  //   } else {
  //     setState(() {
  //       saved = false;
  //     });
  //   }
  // }
}
