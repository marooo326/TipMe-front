import 'package:flutter/cupertino.dart';

class FriendRequestWidget extends StatefulWidget {
  const FriendRequestWidget({
    super.key,
  });

  @override
  State<FriendRequestWidget> createState() => _FriendRequestWidgetState();
}

class _FriendRequestWidgetState extends State<FriendRequestWidget> {
  final _friendNameEditController = TextEditingController();

  @override
  void dispose() {
    _friendNameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "닉네임을 입력해주세요.",
        style: TextStyle(fontSize: 15),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CupertinoTextField(
          controller: _friendNameEditController,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, _friendNameEditController.text);
          },
          child: const Text("Send"),
        ),
      ],
    );
  }
}
