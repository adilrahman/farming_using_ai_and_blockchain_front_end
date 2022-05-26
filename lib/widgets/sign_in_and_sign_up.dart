import 'package:farming_using_ai_and_blockchain_front_end/screens/screens.dart';
import 'package:flutter/material.dart';

// it include the sign and sign up screens with the tab bar
class SignInAndUp extends StatelessWidget {
  const SignInAndUp({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Column(
        children: [
          TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              controller: _tabController,
              indicatorColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "SIGN IN"),
                Tab(
                  text: "SIGN UP",
                )
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SignInScreen(),
              SignUpScreen(),
            ]),
          )
        ],
      ),
    );
  }
}
