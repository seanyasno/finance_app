import 'package:flutter/material.dart';

class ProfitInputExtra extends StatelessWidget {
  final String label;
  final ValueChanged onChangeCallback;
  final Widget extraWidget;

  ProfitInputExtra({this.label, this.onChangeCallback, this.extraWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        extraWidget ?? SizedBox(),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: extraWidget != null ? 0 : 15),
            width: 150,
            height: 35,
            child: TextField(
              cursorColor: Theme.of(context).cursorColor,
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
