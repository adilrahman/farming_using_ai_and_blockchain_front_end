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
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: _response.length, //total project count
            itemBuilder: (context, index) => Center(
                  child: Text(
                    _response[index].toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
      ),
    );
  }
}
