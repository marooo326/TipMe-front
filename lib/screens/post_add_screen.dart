import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/catergory_info_model.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/widgets/basic_text_field_widget.dart';
import 'package:tipme_front/widgets/dialog_button_widget.dart';
import 'package:tipme_front/widgets/tip_text_field_widget.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({
    super.key,
  });

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey.withOpacity(0.2),
          middle: const Text("새로운 포스트 등록"),
          trailing: CupertinoButton(
            onPressed: () async {
              PostModel newPost =
                  Provider.of<PostModel>(context, listen: false);
              newPost.tips.removeWhere((element) => element.isEmpty);
              if (newPost.place == "") {
                await showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return const CupertinoActionSheet(
                      message: Text("장소명은 반드시 입력해야합니다."),
                    );
                  },
                );
              } else if (newPost.tips.isEmpty) {
                await showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return const CupertinoActionSheet(
                      message: Text("최소 한 개 이생의 팁을 입력하세요."),
                    );
                  },
                );
                newPost.tips.add("");
                newPost.notifyListeners();
              } else {
                Navigator.pop(
                  context,
                  newPost,
                );
              }
            },
            padding: EdgeInsets.zero,
            child: const Text(
              "추가",
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 110),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BasicTextFieldWidget(
                prefix: "장소명",
                placeholder: "필수 입력",
              ),
              const Divider(
                thickness: 1,
                color: CupertinoColors.systemGrey,
              ),
              Row(
                children: [
                  const Text(
                    "카테고리",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  DialogButtonWidget(categoryList: Categories.toList()),
                ],
              ),
              const Divider(
                thickness: 1,
                color: CupertinoColors.systemGrey,
              ),
              const TipTextFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
