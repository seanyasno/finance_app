import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
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

  InfoFeesSection({
    @required this.purchasePrice,
    @required this.sellingPrice,
    @required this.sharesQuantity,
    @required this.buyCommission,
    @required this.sellCommission,
    @required this.spreadFee,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfoExpanded(
          'Total Fees',
          NumberFormat().format(_calculateTotalFees()),
          [
            SectionInnerInfo(
              'Buy Commission',
              NumberFormat().format(
                  buyCommission.calculate(data: purchasePrice * sharesQuantity)),
            ),
            SectionInnerInfo(
              'Sell Commission',
              NumberFormat().format(
                  sellCommission.calculate(data: sellingPrice * sharesQuantity)),
            ),
            SectionInnerInfo(
              'Spread Fee',
              NumberFormat().format(_calculateSpreadFee()),
            ),
          ],
        ),
      ],
      gradientColors: [
        Color(0xFFe35d5b),
        Color(0xFFe53935),
      ],
      useVerticalPadding: false,
      addChildrenPadding: false,
    );
  }

  double _calculateTotalFees() {
    return buyCommission.calculate(data: purchasePrice * sharesQuantity) +
        sellCommission.calculate(data: sellingPrice * sharesQuantity) +
        _calculateSpreadFee();
  }

  double _calculateSpreadFee() {
    if (sellingPrice <= purchasePrice) return 0;
    return spreadFee *
        ((sellingPrice * sharesQuantity) - (purchasePrice * sharesQuantity));
  }
}
