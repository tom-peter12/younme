import 'first.dart';
import 'second.dart';
import 'package:flutter/material.dart';

class MyQRApp extends StatefulWidget {
  const MyQRApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyQRApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: qrCode(),
    );
  }
}

class qrCode extends StatefulWidget {
  const qrCode({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<qrCode> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.qr_code,
                  size: 40,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 40,
                ),
              ),
            ],
          ),
          title: const Text(
            "Add Contacts",
          ),
        ),
        body: const TabBarView(
          children: [
            First(),
            Second(),
          ],
        ),
      ),
    );
  }
}