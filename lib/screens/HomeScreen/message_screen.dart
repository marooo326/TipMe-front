
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/message_model.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/services/data_api_service.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late final UserModel user;
  late Future<List<MessageModel>> messages;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserModel>(context, listen: false);
    messages = DataApiService.getMessages(user.token!);
  }

  Future<bool> _showFriendRequestPopup(String sender) async {
    final isAccepted = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("$sender 친구요청"),
        content: const Text("수락하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return isAccepted;
  }

  ListView makeMessageList(AsyncSnapshot<List<MessageModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        MessageModel message = snapshot.data![index];
        return CupertinoListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.sender,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                message.latest,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          leading: const Icon(CupertinoIcons.person_crop_circle),
          trailing: const CupertinoListTileChevron(),
          onTap: () => _showFriendRequestPopup(message.sender),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        middle: Text('Messages'),
      ),
      child: FutureBuilder(
        future: messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: makeMessageList(snapshot),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
