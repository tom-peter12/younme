import 'dart:io';
import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:chatter/helpers.dart';
import 'package:chatter/models/contacts_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../db/contacts_db.dart';

final storage = FlutterSecureStorage();

class First extends StatefulWidget {
  final Contacts? contacts;
  const First({
    Key? key,
    this.contacts,
  }) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  TextEditingController content = TextEditingController();
  File? file;
  TextEditingController title = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  late String number;
  late String username;
  late String publickey;
  late String psk;

  @override
  void initState() {
    super.initState();

    number = widget.contacts?.phone_number ?? '';
    username = widget.contacts?.user_name ?? '';
    publickey = widget.contacts?.public_key ?? '';
    psk = widget.contacts?.preshared_key ?? '';
  }

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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: generate(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // contactInfo == ''
                    // ? const Text('')

                    InkWell(
                      onTap: () {
                        // ignore: avoid_print

                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => SignUpScreen(),
                        //   ),
                        // ),
                        // ignore: avoid_print
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
                            color: Colors.redAccent),
                      ),
                    ),
                    BarcodeWidget(
                      barcode: Barcode.qrCode(
                        errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                      ),
                      data: snapshot.data!,
                      width: 200,
                      height: 100,
                      color: AppColors.cardLight,
                    ),
                  ],
                ),
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
      var _formKey;
      // final isValid = cont.currentState!.validate();

      if (true) {
        final isUpdating = widget.contacts != null;

        if (isUpdating) {
          await updateContact(cont);
        } else {
          await addContact(cont);
        }

        Navigator.of(context).pop();
      }
    }
  }
