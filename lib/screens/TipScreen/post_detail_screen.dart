import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_model.dart';

import '../../services/data_api_service.dart';
import '../../utils/functions.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel post;
  const PostDetailScreen({
    super.key,
    required this.post,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController controller = TextEditingController();
  late final UserModel user;
  late final postId;
  late final String title;
  late final List<TipModel> tips;
  late final Color categoryColor;

  CrossAxisAlignment tipAlign = CrossAxisAlignment.start;

  /// 새로운 팁 추가
  void addNewTip() async {
    // 임시 팁 모델
    TipModel newTip = TipModel(writer: user, comment: controller.text);

    // 팁 추가 요청
    if (newTip.comment.length < 5 || newTip.comment.length > 50) {
      showAlertMessage(context, "팁은 5자 이상 50자 이하로 작성해야합니다.");
      return;
    }

    // 서버에 팁 추가 요청
    final response = await DataApiService.postTip(user.token!, postId, newTip);
    setState(
      () {
        print("Tip add response: $response");
        controller.text = "";
        tips.add(newTip);
      },
    );
  }

  /// 팁 long press event
  void onTipPress(TipModel tip) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("팁을 삭제하시겠습니까?"),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  "삭제",
                  style: TextStyle(
                    color: CupertinoColors.systemRed,
                  ),
                ),
                onPressed: () async {
                  final response =
                      await DataApiService.removeTip(user.token!, tip.id!);
                  if (response == 200) {
                    setState(() {
                      tips.remove(tip);
                    });
                    print("팁 삭제 성공");
                  } else {
                    print(response);
                  }
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    postId = widget.post.id;
    title = widget.post.place;
    tips = widget.post.tips;
    categoryColor = widget.post.category.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        leading: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            size: 30,
          ),
        ),
        backgroundColor: categoryColor.withOpacity(0.8),
        middle: Text(
          title,
          style: const TextStyle(
            color: CupertinoColors.darkBackgroundGray,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  var isMyTip = false;
                  if (tips[index].writer.userName == user.userName) {
                    isMyTip = true;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: isMyTip
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          tips[index].writer.userName,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onLongPress:
                              isMyTip ? () => onTipPress(tips[index]) : () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CupertinoColors.lightBackgroundGray),
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    CupertinoColors.extraLightBackgroundGray),
                            child: Text(tips[index].comment),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 60, left: 5, right: 5),
              decoration: const BoxDecoration(
                color: CupertinoColors.extraLightBackgroundGray,
              ),
              child: CupertinoTextField(
                controller: controller,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: CupertinoColors.white,
                ),
                suffix: CupertinoButton(
                  onPressed: addNewTip,
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.arrow_up_circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
