import 'package:finance_app/components/profit_input/profit_input.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeesSection extends StatelessWidget {
  ValueChanged onBuyingFeeChanged;
  ValueChanged onSellingFeeChanged;
  ValueChanged onSpreadFeeChanged;

  FeesSection(
      this.onBuyingFeeChanged,
      this.onSellingFeeChanged,
      this.onSpreadFeeChanged);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color(0xFFeea849),
              Color(0xFFf46b45),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ProfitInput(
              label: 'Buy Commission',
              onChangeCallback: onBuyingFeeChanged,
            ),
            SizedBox(
              height: 10,
            ),
            ProfitInput(
              label: 'Sell Commission',
              onChangeCallback: onSellingFeeChanged,
            ),
            SizedBox(
              height: 10,
            ),
            ProfitInput(
              label: 'Spread Fee (%)',
              onChangeCallback: onSpreadFeeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
