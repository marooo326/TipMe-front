import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/utils/constants.dart';

class DialogButtonWidget extends StatefulWidget {
  const DialogButtonWidget({
    super.key,
  });

  @override
  State<DialogButtonWidget> createState() => _DialogButtonWidgetState();
}

class _DialogButtonWidgetState extends State<DialogButtonWidget> {
  final List<Categories> categoryList =
      Categories.values.map((category) => category).toList();

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
                setState(() {
                  value.category = categoryList[selectedItem];
                });
              },
              children: List.generate(
                categoryList.length,
                (index) => Center(
                  child: Text(categoryList[index].name),
                ),
              ),
            ),
          ),
          child: Center(
            child: Text(
              value.category.name,
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
