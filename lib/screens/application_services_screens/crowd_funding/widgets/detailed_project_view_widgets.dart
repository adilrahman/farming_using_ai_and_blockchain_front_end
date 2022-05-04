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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          _heading,
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
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
              SizedBox(width: 20),
              Text(
                _heading,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Divider(),
          Text(
            _data,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
    );
  }
}