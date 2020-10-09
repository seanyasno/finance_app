import 'package:flutter/material.dart';

class SectionInnerInfo extends StatelessWidget {
  final String _label;
  final String _value;

  SectionInnerInfo(this._label, this._value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 95,
            child: Text(
              _value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
