import 'package:finance_app/components/expanded_profit_info/expanded_profit_info.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class InfoSection extends StatelessWidget {
  double currentSharePrice;
  double futureSharePrice;
  double spread;
  double sharesAmount;

  double buyCommission;
  double sellCommission;
  double spreadFee;
  
  InfoSection(
      this.currentSharePrice,
      this.futureSharePrice,
      this.spread,
      this.sharesAmount,
      this.buyCommission,
      this.sellCommission,
      this.spreadFee);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 15, top: 15, right: 15),
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
                'Future Share Price', NumberFormat().format(futureSharePrice)),
            SizedBox(
              height: 15,
            ),
            ProfitInfo(
                'Share Growth (%)',
                NumberFormat().format((spread /
                        (currentSharePrice == 0 ? 1 : currentSharePrice)) *
                    100)),
            SizedBox(
              height: 15,
            ),
            ProfitInfo('Total Buying Value',
                NumberFormat().format(currentSharePrice * sharesAmount)),
            SizedBox(
              height: 15,
            ),
            ProfitInfo('Total Selling Value',
                NumberFormat().format(futureSharePrice * sharesAmount)),
            ExpandedProfitInfo(
              title: 'Total Fees',
              titleValue: NumberFormat().format(_getTotalFees()),
              children: [
                ProfitInfo(
                    'Buy Commission', NumberFormat().format(buyCommission)),
                SizedBox(height: 15),
                ProfitInfo(
                    'Sell Commission', NumberFormat().format(sellCommission)),
                SizedBox(height: 15),
                ProfitInfo(
                    'Spread Fee', NumberFormat().format(spread * spreadFee * sharesAmount)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getTotalFees() {
    return buyCommission + sellCommission + (spread * spreadFee * sharesAmount);
  }
}
