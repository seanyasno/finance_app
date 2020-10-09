import 'package:flutter/material.dart';

class SectionInnerInputCommission extends StatelessWidget {
  final String label;
  final Map<String, Object> value;

  SectionInnerInputCommission({
    Key key,
    @required this.label,
    @required this.value,
  })  : assert(value.length == 3),
        super(key: key);

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
        Switch(
          value: value['toggleValue'],
          onChanged: value['toggleChanged'],
          activeColor: Colors.deepOrange,
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
              onChanged: value['inputChanged'],
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
