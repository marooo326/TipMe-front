import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tipme_front/models/chat_room_model.dart';
import 'package:tipme_front/services/data_api_service.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<ChatRoomModel>> chatRooms;

  @override
  void initState() {
    super.initState();
    chatRooms = DataApiService.getChatRooms();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        middle: Text('Messages'),
      ),
      child: FutureBuilder(
        future: chatRooms,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: makeChatList(snapshot),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }

  ListView makeChatList(AsyncSnapshot<List<ChatRoomModel>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var chatRoom = snapshot.data![index];
        return CupertinoListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatRoom.partner,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  chatRoom.latest,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            leading: const Icon(CupertinoIcons.person_crop_circle),
            trailing: const CupertinoListTileChevron(),
            onTap: () => _showFriendRequestPopup(chatRoom.partner));
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Future<void> _showFriendRequestPopup(String partner) async {
    final isAccepted = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("$partner님의 친구요청"),
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
    print(isAccepted);
  }
}
