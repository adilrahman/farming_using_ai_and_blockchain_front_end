import 'package:farming_using_ai_and_blockchain_front_end/color_constants.dart';
import 'package:flutter/material.dart';

class ResponseViewScreen extends StatelessWidget {
  const ResponseViewScreen({Key? key, required response})
      : _response = response,
        super(key: key);

  final _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.gradientSecond,
        title: const Text("recommendation"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: ListView.separated(
            separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Divider(
                    thickness: 0.9,
                    color: Colors.black,
                  ),
                ),
            itemCount: _response.length, //total project count
            itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                          child: Text(
                            _response[index].keys.first.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Text(
                        "remedies",
                        style: TextStyle(color: Colors.black),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(),
                          shrinkWrap: true,
                          itemCount: _response[index].values.first.length,
                          itemBuilder: (context, s_index) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              padding: const EdgeInsets.all(15),
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                    _response[index]
                                        .values
                                        .first[s_index]
                                        .keys
                                        .first
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const Divider(
                                    thickness: 0.9,
                                    color: Colors.white,
                                  ),
                                  Center(
                                      child: Text(
                                    _response[index]
                                        .values
                                        .first[s_index]
                                        .values
                                        .first
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                )),
      ),
    );
  }
}
