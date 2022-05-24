import 'package:flutter/material.dart';

class ContributorsListViewScreen extends StatelessWidget {
  const ContributorsListViewScreen({Key? key, this.details}) : super(key: key);
  final details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contributors List"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      width: 200,
                      child: Text(details[index]["address"].toString())),
                  Expanded(child: Container()),
                  Text(details[index]['amount'].toString() + " ETH")
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: details.length),
      ),
    );
  }
}
