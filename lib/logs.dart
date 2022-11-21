import 'dart:convert';

import 'package:chatter/screens/utils/address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'db/contacts_db.dart';
import 'models/contacts_data.dart';


class ListContacts extends StatelessWidget {
 
  // late ProfileModel profileModel;
  // String profImage = "${ADDRESS}propic/pro";
  ListContacts({Key? key}) : super(key: key);



  Future<dynamic> ListAllCont() async {
        final db = await ContactsDatabase.instance.database;

    final orderBy = '${ContactsField.user_name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableContacts, orderBy: orderBy);

    return result.map((json) => Contacts.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Contacts'),
      ),
      body: FutureBuilder(
        future: ListAllCont(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Container(
            padding: EdgeInsets.all(12),
            child: ListView.separated(
              separatorBuilder: (_, context) =>
                  Divider(height: 10, color: Colors.green),
              itemBuilder: (_, index) {
                List list = snapshot.data;
                return Card(
                  color: Colors.white,
                  shadowColor: Colors.white,
                  // clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          // alignment: Alignment.topRight,
                          children: [
                            Ink.image(
                              width: 60,
                              height: 90,
                              image: NetworkImage("${ADDRESS}propic/"),

                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0,
                              top: 16.0,
                              right: 16.0,
                              bottom: 1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list[index].user_name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),


                              Text(
                                list[index].phone_number,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "Say Hi",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10,),),

                            ],
                          ),
                        ),
                        ButtonBar(),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
            ),
          )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
