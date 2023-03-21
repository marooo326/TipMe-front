import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';

class DialogButtonWidget extends StatefulWidget {
  const DialogButtonWidget({
    super.key,
    required this.categoryList,
  });
  final List<String> categoryList;

  @override
  State<DialogButtonWidget> createState() => _DialogButtonWidgetState();
}

class _DialogButtonWidgetState extends State<DialogButtonWidget> {
  void _showDialog(BuildContext context, Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostModel>(
      builder: (context, value, child) {
        return CupertinoButton(
          onPressed: () => _showDialog(
            context,
            CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: (selectedItem) {
                value.category = widget.categoryList[selectedItem];
                value.notifyListeners();
              },
              children: List.generate(
                widget.categoryList.length,
                (index) => Center(
                  child: Text(
                    widget.categoryList[index],
                  ),
                ),
              ),
            ),
          ),
          child: Center(
            child: Text(
              value.category,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        );
      },
    );
  }
}
