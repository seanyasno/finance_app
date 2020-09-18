import 'package:flutter/material.dart';

class ProfitInfo extends StatelessWidget {
  final String _label;
  final String _value;

  ProfitInfo(this._label, this._value);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 95,
            child: Text(
              _value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
