import 'package:finance_app/components/expanded_profit_info/expanded_profit_info.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoSumSection extends StatelessWidget {
  final double purchasePrice;
  final double sellingPrice;
  final int sharesQuantity;

  final CommissionFee buyCommission;
  final CommissionFee sellCommission;

  InfoSumSection(
      {this.purchasePrice,
      this.sellingPrice,
      this.sharesQuantity,
      this.buyCommission,
      this.sellCommission});

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
              Color(0xFF4286f4),
              Color(0xFF373B44),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ExpandedProfitInfo(
              title: 'Total Buying Value',
              titleValue: NumberFormat().format(_calculateTotalBuyingValue()),
              children: [
                ProfitInfo('Shares Value',
                    NumberFormat().format(purchasePrice * sharesQuantity)),
                SizedBox(height: 10),
                ProfitInfo(
                    'Buy Commission',
                    NumberFormat().format(buyCommission.calculate(
                        data: purchasePrice * sharesQuantity))),
              ],
            ),
            ProfitInfo('Spread', NumberFormat().format(_calculateSpread())),
            ExpandedProfitInfo(
              title: 'Total Selling Value',
              titleValue: NumberFormat().format(_calculateTotalSellingValue()),
              children: [
                ProfitInfo('Shares Value',
                    NumberFormat().format(sellingPrice * sharesQuantity)),
                SizedBox(height: 10),
                ProfitInfo(
                    'Sell Commission',
                    NumberFormat().format(sellCommission.calculate(
                        data: sellingPrice * sharesQuantity))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalBuyingValue() {
    return purchasePrice * sharesQuantity +
        buyCommission.calculate(data: purchasePrice * sharesQuantity);
  }

  double _calculateTotalSellingValue() {
    return sellingPrice * sharesQuantity +
        sellCommission.calculate(data: sellingPrice * sharesQuantity);
  }

  double _calculateSpread() {
    return (sellingPrice * sharesQuantity) - (purchasePrice * sharesQuantity);
  }
}
