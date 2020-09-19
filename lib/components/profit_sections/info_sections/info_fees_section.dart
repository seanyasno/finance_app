import 'package:finance_app/components/expanded_profit_info/expanded_profit_info.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoFeesSection extends StatelessWidget {
  final double purchasePrice;
  final double sellingPrice;
  final int sharesQuantity;

  final CommissionFee buyCommission;
  final CommissionFee sellCommission;
  final double spreadFee;

  InfoFeesSection(
      {this.purchasePrice,
      this.sellingPrice,
      this.sharesQuantity,
      this.buyCommission,
      this.sellCommission,
      this.spreadFee});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color(0xFFe35d5b),
              Color(0xFFe53935),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ExpandedProfitInfo(
              title: 'Total Fees',
              titleValue: NumberFormat().format(_calculateTotalFees()),
              children: [
                ProfitInfo(
                  'Buy Commission',
                  NumberFormat().format(buyCommission.calculate(
                      data: purchasePrice * sharesQuantity)),
                ),
                SizedBox(height: 15),
                ProfitInfo(
                  'Sell Commission',
                  NumberFormat().format(sellCommission.calculate(
                      data: sellingPrice * sharesQuantity)),
                ),
                SizedBox(height: 15),
                ProfitInfo(
                  'Spread Fee',
                  NumberFormat().format(_calculateSpreadFee()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalFees() {
    return buyCommission.calculate(data: purchasePrice * sharesQuantity) +
        sellCommission.calculate(data: sellingPrice * sharesQuantity) +
        _calculateSpreadFee();
  }

  double _calculateSpreadFee() {
    if (sellingPrice <= purchasePrice)
      return 0;
    return (spreadFee / 100) *
        ((sellingPrice * sharesQuantity) -
            (purchasePrice * sharesQuantity));
  }
}
