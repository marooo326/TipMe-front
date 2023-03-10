import 'package:flutter/cupertino.dart';

class CategoryButtonWidget extends StatefulWidget {
  const CategoryButtonWidget({
    super.key,
    this.isAllButton = false,
    required this.text,
    required this.buttonColor,
    required this.updateButtonState,
  });
  final bool isAllButton;
  final String text;
  final Color buttonColor;
  final dynamic updateButtonState;

  @override
  State<CategoryButtonWidget> createState() => CategoryButtonWidgetState();
}

class CategoryButtonWidgetState extends State<CategoryButtonWidget> {
  late bool isSelected;
  late Color textColor;
  late Color buttonBgColor;
  @override
  void initState() {
    super.initState();
    isSelected = true;
    textColor = CupertinoColors.white;
    buttonBgColor = widget.buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    //isButtonClicked = widget.defaultClicked;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
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
        color: buttonBgColor,
        onPressed: () {
          if (isSelected) {
            setUnselected();
          } else {
            setSelected();
          }
          widget.updateButtonState(widget.isAllButton, isSelected);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void setSelected() {
    setState(() {
      textColor = CupertinoColors.white;
      buttonBgColor = widget.buttonColor;
      isSelected = true;
    });
  }

  void setUnselected() {
    setState(() {
      textColor = widget.buttonColor;
      buttonBgColor = CupertinoColors.white;
      isSelected = false;
    });
  }
}
