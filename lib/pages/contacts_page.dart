import 'package:chatter/logs.dart';
import 'package:flutter/material.dart';

import '../screens/contacts_screen.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ListContacts(),
    );
  }
}
