import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tipme_front/models/user_model.dart';
import 'package:tipme_front/screens/login_screen.dart';
import 'package:tipme_front/screens/main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoggedIn = false;
  late UserModel user;

  @override
  void initState() {
    user = UserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: user,
      builder: (context, child) {
        return StreamBuilder<bool>(
          stream: user.loginStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return const MainScreen();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    );
  }
}
