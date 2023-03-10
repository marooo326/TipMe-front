import 'package:flutter/cupertino.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/widgets/category_button_widget.dart';
import 'package:tipme_front/widgets/tip_card_widget.dart';

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
  final int categoryCount = 4;
  late final GlobalKey<CategoryButtonWidgetState> allCategoryWidgetKey;
  late final List<GlobalKey<CategoryButtonWidgetState>> categoryWidgetKeyList;
  final List<String> categoryList = [
    "카페",
    "식당",
    "술집",
    "기타",
  ];
  final List<Color> categoryColorList = [
    CupertinoColors.systemOrange,
    CupertinoColors.systemPurple,
    CupertinoColors.systemGreen,
    CupertinoColors.systemIndigo,
  ];

  @override
  void initState() {
    // 추후 상태관리 패턴 적용 필요
    allCategoryWidgetKey = GlobalKey(); //전체보기 글로벌 키
    List<GlobalKey<CategoryButtonWidgetState>> tempKeyList = [];
    for (var i = 0; i < categoryCount; ++i) {
      tempKeyList.add(GlobalKey());
    } //카테고리 글로벌 키 생성
    categoryWidgetKeyList = tempKeyList;
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
                      text: categoryList[0],
                      buttonColor: categoryColorList[0],
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[1],
                      text: categoryList[1],
                      buttonColor: categoryColorList[1],
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[2],
                      text: categoryList[2],
                      buttonColor: categoryColorList[2],
                      updateButtonState: updateButtonState,
                    ),
                    CategoryButtonWidget(
                      key: categoryWidgetKeyList[3],
                      text: categoryList[3],
                      buttonColor: categoryColorList[3],
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
                Row(
                  children: [
                    TipCardWidget(
                      id: 0,
                      tipCount: 2,
                      title: "Kanna",
                      category: categoryList[0],
                      cardColor: categoryColorList[0],
                    ),
                    TipCardWidget(
                      id: 1,
                      tipCount: 6,
                      title: "심가네 감자탕",
                      category: categoryList[1],
                      cardColor: categoryColorList[1],
                    ),
                  ],
                )
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
