import 'package:flutter/material.dart';
import 'package:flutter_blog/ui/pages/auth/login_page/widgets/login_body.dart';

// 1 Stateful -->

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginBody(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "/post/list");
      }),
    );
  }
}
