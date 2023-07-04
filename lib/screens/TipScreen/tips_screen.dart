import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/category_provider.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/screens/TipScreen/post_add_screen.dart';
import 'package:tipme_front/screens/TipScreen/post_detail_screen.dart';
import 'package:tipme_front/screens/TipScreen/tip_card_widget.dart';
import 'package:tipme_front/services/data_api_service.dart';
import 'package:tipme_front/utils/constants.dart';
import 'package:tipme_front/screens/TipScreen/category_button_widget.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({
    super.key,
  });

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  late final UserModel user;
  late Future<List<PostModel>> posts;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserModel>(context, listen: false);
    posts = DataApiService.getPosts(user.token!);
  }

  void _refreshPost() {
    setState(() {
      posts = DataApiService.getPosts(user.token!);
      print("포스트 다시 불러오기");
    });
  }

  ///카테고리 버튼 생성 메소드
  List<CategoryButtonWidget> _makeCategoryButtons() {
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
  List<GestureDetector> _makeTipCards(
      BuildContext context, List<PostModel> posts) {
    List<GestureDetector> tipsCards = [];
    List<bool> isSelected = Provider.of<CategoryProvider>(context).isSelected;
    for (var post in posts) {
      if (isSelected[post.category.id]) {
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
              ).then((value) => _refreshPost());
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
  void _showPostAddScreen() async {
    try {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider(
            create: (_) => PostModel(
              place: "",
              category: Categories.CAFE,
              tips: [TipModel(writer: user, comment: "")],
            ),
            child: PostAddScreen(user: user),
          );
        },
      );
      _refreshPost();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.lightBackgroundGray,
      child: SafeArea(
        child: CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                backgroundColor: CupertinoColors.lightBackgroundGray,
                middle: Text("Tips"),
              ),
              child: ChangeNotifierProvider<CategoryProvider>(
                create: (_) => CategoryProvider(),
                builder: (context, child) {
                  return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: CupertinoColors.systemTeal,
                      onPressed: _showPostAddScreen,
                      child: const Icon(CupertinoIcons.add),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _makeCategoryButtons(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CupertinoButton(
                                padding: const EdgeInsets.only(right: 15),
                                onPressed: _refreshPost,
                                child: const Row(
                                  children: [
                                    Text(
                                      "포스트 새로고침",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
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
                                    children:
                                        _makeTipCards(context, snapshot.data!),
                                  );
                                } else {
                                  return const Center(
                                    child: CupertinoActivityIndicator(),
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
        ),
      ),
    );
  }
}
