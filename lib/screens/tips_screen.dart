import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/catergory_info_model.dart';
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
  @override
  void initState() {
    super.initState();
  }

  ///카테고리 버튼 생성 메소드
  List<CategoryButtonWidget> makeCategoryButtons() {
    List<CategoryButtonWidget> buttonList = [];
    for (var category in Categories.values) {
      buttonList.add(CategoryButtonWidget(
        id: category.index,
        text: category.name,
        buttonColor: category.color,
      ));
    }
    return buttonList;
  }

  ///임시 카드 제작 메소드
  List<TipCardWidget> makeTipCards(BuildContext context) {
    List<TipCardWidget> cardList = [];
    var categoryInfo = Provider.of<CategoryInfoModel>(context);
    for (var category in Categories.values) {
      if (categoryInfo.isSelected[category.index]) {
        cardList.add(TipCardWidget(
          id: category.index,
          tipCount: 123,
          title: "Temp",
          cardColor: category.color,
          category: category.name,
        ));
      }
    }

    return cardList;
  }

  void showPostDetailWidget() {}

  ///포스트 추가 팝업 실행 메소드
  void showPostAddScreen() async {
    try {
      PostModel newPost = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (_) => PostModel(
                place: "", category: Categories.cafe.name, tips: [""]),
            child: const PostAddScreen(),
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
          child: ChangeNotifierProvider<CategoryInfoModel>(
            create: (_) => CategoryInfoModel(),
            builder: (context, child) {
              return Scaffold(
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: FloatingActionButton(
                    onPressed: showPostAddScreen,
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
                            children: makeTipCards(context)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
