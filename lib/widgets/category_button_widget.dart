import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/catergory_info_model.dart';

class CategoryButtonWidget extends StatefulWidget {
  const CategoryButtonWidget({
    super.key,
    required this.id,
    required this.text,
    required this.buttonColor,
  });
  final int id;
  final String text;
  final Color buttonColor;

  @override
  State<CategoryButtonWidget> createState() => CategoryButtonWidgetState();
}

class CategoryButtonWidgetState extends State<CategoryButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryInfoModel>(
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.buttonColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(100),
            color: value.isSelected[widget.id]
                ? widget.buttonColor
                : CupertinoColors.white,
            onPressed: () {
              value.onClicked(widget.id);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: value.isSelected[widget.id]
                      ? CupertinoColors.white
                      : widget.buttonColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
