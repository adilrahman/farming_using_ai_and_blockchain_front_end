import 'package:flutter/material.dart';

class DetailTileRight extends StatelessWidget {
  const DetailTileRight({
    Key? key,
    required String data,
    required String heading,
  })  : _data = data,
        _heading = heading,
        super(key: key);

  final String _data;
  final String _heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _data,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          _heading,
          style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
        ),
      ],
    );
  }
}

class SingleDetailChildRight extends StatelessWidget {
  const SingleDetailChildRight({
    Key? key,
    required String heading,
    required String data,
  })  : _heading = heading,
        _data = data,
        super(key: key);

  final String _heading;
  final String _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                _heading,
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const Divider(),
          Text(
            _data,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class DialogeTextField extends StatelessWidget {
  const DialogeTextField({
    Key? key,
    required TextEditingController textController,
    required String hintText,
  })  : _textController = textController,
        _hintText = hintText,
        super(key: key);

  final TextEditingController _textController;
  final String _hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textController,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            hintStyle: const TextStyle(fontSize: 15.0, color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            border: const OutlineInputBorder(),
            hintText: _hintText));
  }
}
