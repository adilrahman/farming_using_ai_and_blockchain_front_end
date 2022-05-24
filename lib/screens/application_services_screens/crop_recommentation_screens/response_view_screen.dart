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
        title: const Text(
          "Recommendation",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
            itemCount: _response.length, //total project count
            itemBuilder: (context, index) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _response[index]["crop"].toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            "percentage : ${_response[index]["support"] * 100}%",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
