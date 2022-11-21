import 'dart:convert';

import 'package:chatter/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../db/contacts_db.dart';
import '../../models/contacts_data.dart';

final storage = FlutterSecureStorage();

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  get contacts => null;

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  bool camState = false;
  bool saved = false;
  bool isLoading = false;
  late Contacts contact;
  final _formkey = GlobalKey<FormState>();
  late String number;
  late String username;
  late String publickey;
  late String psk;

  String? _qrInfo = 'Scan a QR/Bar code';

  Future<String> generate() async {
    String? username = await storage.read(key: "username");
    String? number = await storage.read(key: "number");

    var contactInfo = {
      "username": username!,
      "phone_number": number!,
      "public_key": "string",
      "psk": "presharedkey"
    };
    return json.encode(contactInfo);
  }

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
    return FutureBuilder(
      future: generate(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
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
                        saved ? Text("Saved") : Text("Not Saved"),
                        Text(
                          "Code :" + (_qrInfo!),
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
                            addOrUpdateNote(snapshot.data!);
                          },
                          child: Container(
                            child: const Text("Save"),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                color: Color.fromARGB(255, 12, 135, 115)),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }

  Future updateContact(cont) async {
    final contact = widget.contacts!.copy(
      phone_number: number,
      user_name: number,
      public_key: publickey,
      preshared_key: psk,
    );

    await ContactsDatabase.instance.update(contact);
  }

  Future addContact(cont) async {
    var data = json.decode(cont);
    final contact = Contacts(
      phone_number: data['phone_number'],
      user_name: data['username'],
      public_key: data['public_key'],
      preshared_key: data['psk'],
    );

    await ContactsDatabase.instance.create(contact);
  }

  void addOrUpdateNote(cont) async {
    Contacts cont = (await ContactsDatabase.instance.readContacts());
    print(cont.user_name);
    print("oui oui oiu");

    var _formKey;
    // final isValid = cont.currentState!.validate();

    if (true) {
      final isUpdating = widget.contacts != null;

      if (isUpdating) {
        await updateContact(cont);
        setState(() {
          saved = true;
        });
      } else {
        // await addContact(cont);
        setState(() {
          saved = true;
        });
      }

      // Navigator.of(context).pop();
    }
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
