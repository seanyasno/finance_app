import 'package:flutter/material.dart';

class SectionInnerInput extends StatelessWidget {
  final String label;
  final ValueChanged onChangeCallback;

  SectionInnerInput({
    Key key,
    @required this.label,
    @required this.onChangeCallback,
  }) : super(key: key);

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
        Flexible(
          child: Container(
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
