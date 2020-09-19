import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoShareSection extends StatelessWidget {
  final double purchasePrice;
  final double sellingPrice;
  final int sharesQuantity;

  final CommissionFee buyCommission;
  final CommissionFee sellCommission;
  final double spreadFee;

  final List<Widget> children;

  InfoShareSection(
      {this.purchasePrice,
      this.sellingPrice,
      this.sharesQuantity,
      this.buyCommission,
      this.sellCommission,
      this.spreadFee,
      this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color(0xFF56CCF2),
              Color(0xFF2F80ED),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Column(
              children: children ?? [],
            ),
            ProfitInfo(
                'Share Growth (%)', _fixNaN(NumberFormat().format((sellingPrice - purchasePrice) / purchasePrice * 100))),
            SizedBox(height: 10),
            ProfitInfo('Return On Investment (%)',
                _fixNaN(NumberFormat().format(_calculateROI()))),
          ],
        ),
      ),
    );
  }

  String _fixNaN(String value) {
    return value == "NaN" ? '0' : value;
  }

  double _calculateProfit() {
    return (sellingPrice * sharesQuantity) -
        (purchasePrice * sharesQuantity) -
        (sellingPrice > purchasePrice
            ? _calculateTotalFees()
            : buyCommission.calculate(data: sharesQuantity * purchasePrice) + sellCommission.calculate(data: sharesQuantity * sellingPrice));
  }

  double _calculateTotalFees() {
    double spread = (sellingPrice * sharesQuantity) - (purchasePrice * sharesQuantity);
    return buyCommission.calculate(data: sharesQuantity * purchasePrice) + sellCommission.calculate(data: sharesQuantity * sellingPrice) + (sellingPrice > purchasePrice ? spread * spreadFee : 0);
  }

  double _calculateROI() {
    double totalCommissions = buyCommission.calculate(data: sharesQuantity * purchasePrice) + sellCommission.calculate(data: sharesQuantity * sellingPrice);
    return (_calculateProfit() / (purchasePrice * sharesQuantity + totalCommissions)) * 100;
  }
}
