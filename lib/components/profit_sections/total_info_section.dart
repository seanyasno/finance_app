import 'package:finance_app/components/expanded_profit_info/expanded_profit_info.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TotalInfoSection extends StatelessWidget {
  double purchasePrice;
  double sellingPrice;
  double spread;
  double sharesQuantity;

  double buyCommission;
  double sellCommission;
  double spreadFees;

  TotalInfoSection(
      {this.purchasePrice,
      this.sellingPrice,
      this.spread,
      this.sharesQuantity,
      this.buyCommission,
      this.sellCommission,
      this.spreadFees});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
            ProfitInfo(
                'Profit / Loss', NumberFormat().format(_getFinalValue())),
            SizedBox(height: 15),
            ProfitInfo('Total Buying Value',
                NumberFormat().format(purchasePrice * sharesQuantity)),
            SizedBox(height: 15),
            ProfitInfo('Total Selling Value',
                NumberFormat().format(sellingPrice * sharesQuantity)),
            ExpandedProfitInfo(
              title: 'Total Fees',
              titleValue: NumberFormat().format(_calculateTotalFees()),
              children: [
                ProfitInfo(
                    'Buy Commission', NumberFormat().format(buyCommission)),
                SizedBox(height: 15),
                ProfitInfo(
                    'Sell Commission', NumberFormat().format(sellCommission)),
                SizedBox(height: sellingPrice > purchasePrice ? 15 : 0),
                sellingPrice > purchasePrice ? ProfitInfo(
                    'Spread Fee', NumberFormat().format(spread * spreadFees)) : SizedBox(height: 0,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalFees() {
    return buyCommission + sellCommission + (sellingPrice > purchasePrice ? spread * spreadFees : 0);
  }

  double _getFinalValue() {
    return (sellingPrice * sharesQuantity) -
                (purchasePrice * sharesQuantity) -
                (sellingPrice >
            purchasePrice
        ? _calculateTotalFees()
        : buyCommission + sellCommission);
  }
}
