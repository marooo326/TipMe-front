import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/screens/TipScreen/tip_text_field_widget.dart';
import 'package:tipme_front/services/data_api_service.dart';
import 'package:tipme_front/widgets/basic_text_field_widget.dart';
import 'package:tipme_front/widgets/dialog_button_widget.dart';
import 'package:tipme_front/utils/functions.dart';

class PostAddScreen extends StatefulWidget {
  final UserModel user;
  const PostAddScreen({
    super.key,
    required this.user,
  });

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  bool _isTipValid(PostModel newPost) {
    if (newPost.place == "") {
      showAlertMessage(context, "장소명을 반드시 입력해주세요");
      return false;
    } else if (newPost.isEmpty()) {
      showAlertMessage(context, "최소 한 개 이생의 팁을 입력하세요.");
      newPost.initTips(widget.user);
      return false;
    } else {
      for (var tip in newPost.tips) {
        if (tip.comment.length < 5 || tip.comment.length > 100) {
          showAlertMessage(context, "모든 팁은 5자 이상 100자 이하여야합니다.");
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.lightBackgroundGray,
          middle: const Text("새로운 포스트 등록"),
          trailing: CupertinoButton(
            onPressed: () async {
              PostModel newPost =
                  Provider.of<PostModel>(context, listen: false);
              if (_isTipValid(newPost)) {
                final reponse = await DataApiService.postNewPost(
                    widget.user.token!, newPost);
                print(reponse);
                Navigator.pop(context);
              }
            },
            padding: EdgeInsets.zero,
            child: const Text(
              "추가",
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
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
                children: const [
                  Text(
                    "카테고리",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  DialogButtonWidget(),
                ],
              ),
              const Divider(
                thickness: 1,
                color: CupertinoColors.systemGrey,
              ),
              TipTextFieldWidget(user: widget.user),
            ],
          ),
        ),
      ),
    );
  }
}
