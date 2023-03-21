import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';

class TipTextFieldWidget extends StatefulWidget {
  const TipTextFieldWidget({
    super.key,
  });

  @override
  State<TipTextFieldWidget> createState() => _TipTextFieldWidgetState();
}

class _TipTextFieldWidgetState extends State<TipTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, value, child) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: value.tips.length,
            itemBuilder: (context, index) {
              return CupertinoTextField(
                controller: TextEditingController(text: value.tips[index]),
                onChanged: (String tip) {
                  value.tips[index] = tip;
                },
                prefix: index == 0
                    ? SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "팁",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.only(bottom: 3),
                              onPressed: () {
                                value.addTip(index);
                              },
                              child: const Icon(
                                CupertinoIcons.add_circled,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(width: 60),
                suffix: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      if (value.tips.length > 1) {
                        value.removeTip(index);
                      }
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.minus_circle,
                    size: 25,
                  ),
                ),
                textAlignVertical: TextAlignVertical.bottom,
                cursorHeight: 15,
                placeholder: "입력하세요.",
                placeholderStyle: const TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemGrey,
                ),
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 15,
                  bottom: 15,
                ),
                decoration: const BoxDecoration(),
              );
            },
          ),
        );
      },
    );
  }
}
