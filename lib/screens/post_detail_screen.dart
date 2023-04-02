import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/catergory_info_model.dart';
import 'package:tipme_front/models/post_model.dart';
import 'package:tipme_front/models/tip_model.dart';
import 'package:tipme_front/models/user_info_model.dart';
import 'package:tipme_front/services/data_api_service.dart';

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
  late final UserInfoModel user;
  late final String title;
  late final List<TipModel> tips;
  late final Color categoryColor;

  @override
  void initState() {
    user = Provider.of<UserInfoModel>(context, listen: false);
    title = widget.post.place;
    tips = widget.post.tips;
    categoryColor = Categories.getColor(widget.post.category);
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
        padding: const EdgeInsets.only(top: 110),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tips[index].writer.userName!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CupertinoColors.lightBackgroundGray),
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.extraLightBackgroundGray),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tips[index].comment),
                            ],
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
                  onPressed: () {
                    TipModel newTip =
                        TipModel(writer: user, comment: controller.text);
                    DataApiService.postTip(user, widget.post.id!, newTip);
                    setState(() {
                      controller.text = "";
                      tips.add(newTip);
                    });
                  },
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
