import 'package:finance_app/components/profit_input/profit_input.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SimpleShareSection extends StatelessWidget {
  ValueChanged<String> onPurchasePriceChanged;
  ValueChanged<String> onSellingPriceChanged;
  ValueChanged<String> onShareQuantityChanged;

  SimpleShareSection(this.onPurchasePriceChanged,
      this.onSellingPriceChanged, this.onShareQuantityChanged);

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
              Color(0xFF38ef7d),
              Color(0xFF11998e),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ProfitInput(
              label: 'Purchase Price',
              onChangeCallback: onPurchasePriceChanged,
            ),
            SizedBox(
              height: 10,
            ),
            ProfitInput(
              label: 'Selling Price',
              onChangeCallback: onSellingPriceChanged,
            ),
            SizedBox(
              height: 10,
            ),
            ProfitInput(
              label: 'Shares Quantity',
              onChangeCallback: onShareQuantityChanged,
            ),
          ],
        ),
      ),
    );
  }
}
