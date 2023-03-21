import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/screens/post_add_screen.dart';
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
  final List<String> categoryList = ["카페", "식당", "술집", "기타"];
  late final GlobalKey<CategoryButtonWidgetState> allCategoryWidgetKey;
  late final List<GlobalKey<CategoryButtonWidgetState>> categoryWidgetKeyList;
  final List<Color> categoryColorList = [
    CupertinoColors.systemOrange,
    CupertinoColors.systemPurple,
    CupertinoColors.systemGreen,
    CupertinoColors.systemIndigo,
    CupertinoColors.systemPink,
  ];

  @override
  void initState() {
    // 추후 상태관리 패턴 적용 필요
    allCategoryWidgetKey = GlobalKey();
    categoryWidgetKeyList = makeCategoryKeys();
    super.initState();
  }

  List<GlobalKey<CategoryButtonWidgetState>> makeCategoryKeys() {
    List<GlobalKey<CategoryButtonWidgetState>> keyList = [];
    for (var i = 0; i < categoryList.length; ++i) {
      keyList.add(GlobalKey());
    } //카테고리 글로벌 키 생성
    return keyList;
  }

  List<CategoryButtonWidget> makeCategoryButtons() {
    List<CategoryButtonWidget> buttonList = [
      CategoryButtonWidget(
        text: "전체보기",
        key: allCategoryWidgetKey,
        buttonColor: CupertinoColors.systemBlue,
        isAllButton: true,
        updateButtonState: updateCategoryButtonState,
      ),
    ];
    for (var i = 0; i < categoryList.length; ++i) {
      buttonList.add(CategoryButtonWidget(
        key: categoryWidgetKeyList[i],
        text: categoryList[i],
        buttonColor: categoryColorList[i],
        updateButtonState: updateCategoryButtonState,
      ));
    }
    return buttonList;
  }

  List<TipCardWidget> makeTipCards() {
    return [
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
      TipCardWidget(
        id: 2,
        tipCount: 4,
        title: "수포차",
        category: categoryList[2],
        cardColor: categoryColorList[2],
      ),
      TipCardWidget(
        id: 3,
        tipCount: 1,
        title: "기타",
        category: categoryList[3],
        cardColor: categoryColorList[3],
      ),
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
      TipCardWidget(
        id: 2,
        tipCount: 4,
        title: "수포차",
        category: categoryList[2],
        cardColor: categoryColorList[2],
      ),
    ];
  }

  void updateCategoryButtonState(bool isAllButton, bool isSelected) {
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

  void showPostDetailWidget() {}

  void showAddPostWidget() async {
    try {
      PostModel newPost = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (_) =>
                PostModel(place: "", category: categoryList[0], tips: [""]),
            child: PostAddScreen(
              categoryList: categoryList,
            ),
          );
        },
      );
      print(newPost);
    } catch (e) {
      print("뒤로가기");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey.withOpacity(0.2),
            middle: const Text("Tips"),
            trailing: const Icon(CupertinoIcons.search),
          ),
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                onPressed: showAddPostWidget,
                child: const Icon(CupertinoIcons.add),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 110),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: makeCategoryButtons(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                          onPressed: () {},
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
                          ))
                    ],
                  ),
                  Expanded(
                    child: GridView.extent(
                      padding: const EdgeInsets.only(bottom: 300),
                      maxCrossAxisExtent: 200,
                      children: makeTipCards(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
