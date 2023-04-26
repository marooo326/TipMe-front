
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/services/data_api_service.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  late final UserModel user;
  late final Future<List<UserModel>> friends;

  @override
  void initState() {
    user = Provider.of<UserModel>(context, listen: false);
    friends = DataApiService.getFriends(user.token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        middle: Text('Friends'),
      ),
      child: FutureBuilder(
        future: friends,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel friend = snapshot.data![index];
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        CupertinoIcons.person_crop_circle,
                        size: 70,
                      ),
                      Text(
                        friend.userName,
                        maxLines: 1,
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
