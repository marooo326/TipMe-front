import 'package:flutter/cupertino.dart';

class TextFieldDialogWidget extends StatefulWidget {
  final String message;
  final String placeholder;
  const TextFieldDialogWidget({
    super.key,
    required this.message,
    this.placeholder = "",
  });

  @override
  State<TextFieldDialogWidget> createState() => _TextFieldDialogWidgetState();
}

class _TextFieldDialogWidgetState extends State<TextFieldDialogWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: 50),
      child: CupertinoActionSheet(
        title: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemBlue,
            ),
          ),
        ),
        message: CupertinoTextField(
          controller: _controller,
          textAlign: TextAlign.center,
          autofocus: true,
          placeholder: widget.placeholder,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context, _controller.text);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              '취소',
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
