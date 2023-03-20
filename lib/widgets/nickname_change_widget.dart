import 'package:flutter/cupertino.dart';

class NicknameChangeWidget extends StatefulWidget {
  const NicknameChangeWidget({
    super.key,
  });

  @override
  State<NicknameChangeWidget> createState() => _NicknameChangeWidgetState();
}

class _NicknameChangeWidgetState extends State<NicknameChangeWidget> {
  String message = "3~8자 사이의 닉네임을 입력해주세요.\n중복 및 공백은 허용되지 않습니다.";
  bool isValid = true;
  final _nicknameEditController = TextEditingController();
  void changeGuide() {
    setState(() {
      isValid = false;
      message = "다시 입력해주세요";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:
              isValid ? CupertinoColors.systemGreen : CupertinoColors.systemRed,
        ),
      ),
      message: CupertinoTextField(
        controller: _nicknameEditController,
        textAlign: TextAlign.center,
        maxLength: 8,
        autofocus: true,
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Change'),
          onPressed: () {
            if (_nicknameEditController.text.length < 3) {
              //nick name 유효한지 검증하는 로직 추가 예정
              changeGuide();
            } else {
              //print(_nicknameEditController.text);
              Navigator.pop(context, _nicknameEditController.text);
            }
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Cancle',
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
