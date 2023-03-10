import 'package:flutter/cupertino.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/widgets/category_button_widget.dart';

class TipsScreen extends StatefulWidget {
  final UserInfoModel userInfo;
  const TipsScreen({
    super.key,
    required this.userInfo,
  });

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  late final GlobalKey<CategoryButtonWidgetState> allCategoryWidgetKey;
  late final List<GlobalKey<CategoryButtonWidgetState>> categoryWidgetKeyList;

  @override
  void initState() {
    allCategoryWidgetKey = GlobalKey();
    categoryWidgetKeyList = [GlobalKey(), GlobalKey(), GlobalKey()];
    super.initState();
  }

  bool isButtonEnabled = true;
  Color buttonColor = CupertinoColors.systemBlue;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0.2),
            middle: const Text("Tips"),
            trailing: const Icon(CupertinoIcons.search),
            // leading: CupertinoButton(
            //     padding: const EdgeInsets.all(0),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: const [
            //         Text(
            //           "전체보기",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: CupertinoColors.black),
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Icon(
            //           CupertinoIcons.chevron_down,
            //           size: 15,
            //           color: CupertinoColors.black,
            //         ),
            //       ],
            //     ),
            //     onPressed: () {},),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Column(
              children: [
                Row(
                  children: [
                    CategoryButtonWidget(
                      text: "전체보기",
                      key: allCategoryWidgetKey,
                      buttonColor: buttonColor,
                      isAllButton: true,
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[0],
                      text: "카페",
                      buttonColor: CupertinoColors.systemOrange,
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[1],
                      text: "식당",
                      buttonColor: CupertinoColors.systemPurple,
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[2],
                      text: "술집",
                      buttonColor: CupertinoColors.systemGreen,
                      updateButtonState: updateButtonState,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        child: Row(
                          children: const [
                            Text(
                              "최신 등록 순",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: 10,
                              color: CupertinoColors.black,
                            )
                          ],
                        ),
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateButtonState(bool isAllButton, bool isSelected) {
    setState(
      () {
        if (isAllButton) {
          if (isSelected) {
            for (var key in categoryWidgetKeyList) {
              key.currentState!.setSelected();
            }
          } else if (!isSelected) {
            for (var key in categoryWidgetKeyList) {
              key.currentState!.setUnselected();
            }
          }
        } else {
          var isAllSelected = true;
          if (isSelected) {
            for (var key in categoryWidgetKeyList) {
              isAllSelected = isAllSelected && key.currentState!.isSelected;
            }
          } else if (!isSelected) {
            for (var key in categoryWidgetKeyList) {
              isAllSelected = isAllSelected && key.currentState!.isSelected;
            }
          }
          isAllSelected
              ? allCategoryWidgetKey.currentState!.setSelected()
              : allCategoryWidgetKey.currentState!.setUnselected();
        }
      },
    );
  }
}
