import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';

class BasicTextFieldWidget extends StatefulWidget {
  const BasicTextFieldWidget({
    super.key,
    required this.prefix,
    required this.placeholder,
  });
  final String prefix;
  final String placeholder;

  @override
  State<BasicTextFieldWidget> createState() => BasicTextFieldWidgetState();
}

class BasicTextFieldWidgetState extends State<BasicTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, value, child) {
        return Column(
          children: [
            CupertinoTextField(
              onChanged: (String text) {
                value.place = text;
              },
              prefix: SizedBox(
                width: 60,
                child: Text(
                  widget.prefix,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textAlignVertical: TextAlignVertical.bottom,
              cursorHeight: 15,
              placeholder: widget.placeholder,
              placeholderStyle: const TextStyle(
                  fontSize: 15, color: CupertinoColors.systemGrey),
              padding: const EdgeInsets.only(
                left: 40,
                top: 15,
                bottom: 15,
              ),
              decoration: const BoxDecoration(),
            ),
          ],
        );
      },
    );
  }
}
