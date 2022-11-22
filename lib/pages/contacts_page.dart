import 'package:chatter/logs.dart';
import 'package:flutter/material.dart';

import '../screens/contacts_screen.dart';


class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  // _ContactsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ListContacts(),
    );
  }
}
