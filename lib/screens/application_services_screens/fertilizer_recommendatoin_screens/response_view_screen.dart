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
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  thickness: 3,
                  color: Colors.white60,
                ),
            itemCount: _response.length, //total project count
            itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      Text(
                        _response[index].keys.first.toString(),
                        style: TextStyle(
                            color: AppColor.gradientSecond,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          shrinkWrap: true,
                          itemCount: _response[index].values.first.length,
                          itemBuilder: (context, s_index) {
                            return Column(
                              children: [
                                Center(
                                    child: Text(
                                  _response[index]
                                      .values
                                      .first[s_index]
                                      .keys
                                      .first
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(_response[index]
                                        .values
                                        .first[s_index]
                                        .values
                                        .first
                                        .toString())),
                              ],
                            );
                          }),
                    ],
                  ),
                )),
      ),
    );
  }
}

// Text(
                    // _response[index].toString(),
                    // style: TextStyle(fontSize: 12),
                  // )
// 

// child: Text(_response[index].values.first.toString()),