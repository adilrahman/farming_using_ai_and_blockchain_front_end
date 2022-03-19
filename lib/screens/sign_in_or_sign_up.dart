import 'package:farming_using_ai_and_blockchain_front_end/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatefulWidget {
  // login entry point
  // contains the background images and the sign in and sign up widgets in a stack manner
  SignInOrSignUp({Key? key}) : super(key: key);

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImageOfSign(),
        SignInAndUp(tabController: _tabController),
      ],
    );
  }
}
