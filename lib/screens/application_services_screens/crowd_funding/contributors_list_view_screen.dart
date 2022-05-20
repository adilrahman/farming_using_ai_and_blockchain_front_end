import 'package:flutter/material.dart';

class ContributorsListViewScreen extends StatelessWidget {
  const ContributorsListViewScreen({Key? key, this.projectContractAddress})
      : super(key: key);
  final projectContractAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contributors List"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      width: 200,
                      child: Text("0xabccnjsnjnsjdjnjsndnsdniasgidhajk")),
                  Expanded(child: Container()),
                  Text("0.4 ETH")
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 5),
      ),
    );
  }
}
