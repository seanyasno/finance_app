import 'package:flutter/material.dart';

class ProfitInput extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChangeCallback;

  ProfitInput({Key key, this.label, this.onChangeCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 15),
            width: 150,
            height: 35,
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: onChangeCallback,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}