import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/catergory_info_model.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/screens/post_add_screen.dart';
import 'package:tipme_front/screens/post_detail_screen.dart';
import 'package:tipme_front/services/data_api_service.dart';
import 'package:tipme_front/widgets/category_button_widget.dart';
import 'package:tipme_front/widgets/tip_card_widget.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({
    super.key,
  });

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  late final UserInfoModel user;
  late Future<List<PostModel>> posts;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserInfoModel>(context, listen: false);
    posts = DataApiService.getPosts(user);
  }

  void refreshPost() {
    setState(() {
      posts = DataApiService.getPosts(user);
      print("새로고침");
    });
  }

  ///카테고리 버튼 생성 메소드
  List<CategoryButtonWidget> makeCategoryButtons() {
    List<CategoryButtonWidget> buttonList = [
      const CategoryButtonWidget(
        id: 0,
        text: "전체보기",
        buttonColor: CupertinoColors.systemBlue,
      )
    ];
    for (var category in Categories.values) {
      buttonList.add(
        CategoryButtonWidget(
          id: category.index + 1,
          text: category.name,
          buttonColor: category.color,
        ),
      );
    }
    return buttonList;
  }

  ///카드 제작 메소드
  List<GestureDetector> makeTipCards(
      BuildContext context, List<PostModel> posts) {
    List<GestureDetector> tipsCards = [];
    List<bool> isSelected = Provider.of<CategoryInfoModel>(context).isSelected;
    for (var post in posts) {
      if (isSelected[Categories.getIndex(post.category)]) {
        tipsCards.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return Provider.value(
                      value: user,
                      child: PostDetailScreen(
                        post: post,
                      ),
                    );
                  },
                ),
              ).then((value) => refreshPost());
            },
            child: TipCardWidget(
              key: UniqueKey(),
              post: post,
            ),
          ),
        );
      }
    }
    return tipsCards;
  }

  ///포스트 추가 팝업 실행 메소드
  void showPostAddScreen() async {
    try {
      PostModel newPost = await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (_) => PostModel(
              place: "",
              category: Categories.cafe.name,
              tips: [TipModel(writer: user, comment: "")],
            ),
            child: PostAddScreen(user: user),
          );
        },
      );
      newPost.printInfo();
    } catch (e) {
      print("뒤로가기");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: CupertinoColors.lightBackgroundGray,
            middle: Text("Tips"),
            trailing: Icon(CupertinoIcons.search),
          ),
          child: ChangeNotifierProvider<CategoryInfoModel>(
            create: (_) => CategoryInfoModel(),
            builder: (context, child) {
              return Scaffold(
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: FloatingActionButton(
                    backgroundColor: CupertinoColors.systemTeal,
                    onPressed: showPostAddScreen,
                    child: const Icon(CupertinoIcons.add),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: posts,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.extent(
                                padding: const EdgeInsets.only(bottom: 300),
                                maxCrossAxisExtent: 250,
                                children: makeTipCards(context, snapshot.data!),
                              );
                            } else {
                              return const Center(
                                child: Text("There's no data"),
                              );
                            }
                          },
                        ),
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
