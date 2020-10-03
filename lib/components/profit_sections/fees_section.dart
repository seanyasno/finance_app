import 'package:finance_app/components/profit_input/profit_input.dart';
import 'package:finance_app/components/profit_input_extra/profit_input_extra.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeesSection extends StatelessWidget {
  ValueChanged onBuyingFeeChanged;
  ValueChanged onSellingFeeChanged;
  ValueChanged onSpreadFeeChanged;

  Widget buyExtraWidget;
  Widget sellExtraWidget;

  bool useBuyPercentage = false;
  bool useSellPercentage = false;

  FeesSection(this.onBuyingFeeChanged, this.onSellingFeeChanged,
      this.onSpreadFeeChanged,
      {this.buyExtraWidget, this.sellExtraWidget, this.useBuyPercentage, this.useSellPercentage});

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
            ProfitInputExtra(
              label: 'Buy Commission${useBuyPercentage == true ? ' (%)' : ''}',
              onChangeCallback: onBuyingFeeChanged,
              extraWidget: buyExtraWidget,
            ),
            SizedBox(
              height: 10,
            ),
            ProfitInputExtra(
              label: 'Sell Commission${useSellPercentage == true ? ' (%)' : ''}',
              onChangeCallback: onSellingFeeChanged,
              extraWidget: sellExtraWidget,
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
