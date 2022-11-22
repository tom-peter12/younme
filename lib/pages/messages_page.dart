import 'package:chatter/db/contacts_db.dart';
import 'package:chatter/models/models.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/widgets/widgets.dart';
// import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import '../helpers.dart';
import '../screens/utils/address.dart';

// class MessagesPage extends StatelessWidget {
//   const MessagesPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(_delegate),
//         )
//       ],
//     );
//   }

//   Widget _delegate(BuildContext context, int index) {
//     final Faker faker = Faker();
//     final date = Helpers.randomDate();
//     return _MessageTitle(
//       messageData: MessageData(
//         senderName: faker.person.name(),
//         message: faker.lorem.sentence(),
//         messageDate: date,
//         dateMessage: Jiffy(date).fromNow(),
//         profilePicture: Helpers.randomPictureUrl(),
//       ),
//     );
//   }
// }

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagesPage();
}

class _MessagesPage extends State<MessagePage> {
  // const _MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadCWM(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(_delegate),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      // child: CustomScrollView(
      //   slivers: [
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(_delegate),
      //     )
      //   ],
      // ),
    );
  }

  Widget _delegate(BuildContext context, int index) {
    // final Faker faker = Faker();
    final date = Helpers.randomDate();
    // String data = ContactsDatabase.instance.readContacts() as String;
    return _MessageTitle(
      messageData: MessageData(
        senderName: "sender",
        message: "message",
        messageDate: date,
        dateMessage: Jiffy(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl(),
      ),
    );
  }

  loadCWM() async {
    if (storage.read(key: "token") == null) {
      print("it is null bruh!");

// you need to reroute the user to the login page

    }

    String? token = await storage.read(key: "token");
    // print(token);
    // print(token.toString());
    // print(token)
    var headers = {
      'accept': 'application/json',
      'Authorization': "Bearer " + token.toString(),
    };

    var url = Uri.parse(ADDRESS + 'loadmessage');
    var res = await http.get(url, headers: headers);
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print("Right here, right here!\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    // print(res.body);
    return res.body;
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFaded,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textLigth,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
