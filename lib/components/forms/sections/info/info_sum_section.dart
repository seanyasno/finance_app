import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoSumSection extends StatelessWidget {
  final double purchasePrice;
  final double sellingPrice;
  final int sharesQuantity;

  final CommissionFee buyCommission;
  final CommissionFee sellCommission;
  final double spreadFee;

  InfoSumSection({
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
          'Total Buying Value',
          NumberFormat().format(_calculateTotalBuyingValue()),
          [
            SectionInnerInfo('Shares Buying Value', NumberFormat().format(purchasePrice * sharesQuantity)),
            SectionInnerInfo('Buy Commission', NumberFormat().format(buyCommission.calculate(
                data: purchasePrice * sharesQuantity))),
          ],
        ),
        SectionInnerInfo('Spread', NumberFormat().format(_calculateSpread())),
        SectionInnerInfoExpanded(
          'Total Selling Value',
          NumberFormat().format(_calculateTotalSellingValue()),
          [
            SectionInnerInfo('Shares Buying Value', NumberFormat().format(sellingPrice * sharesQuantity)),
            SectionInnerInfo('Buy Commission', NumberFormat().format(sellCommission.calculate(
                data: sellingPrice * sharesQuantity))),
          ],
        ),
      ],
      gradientColors: [
        Color(0xFF4286f4),
        Color(0xFF373B44),
      ],
      useVerticalPadding: false,
      addChildrenPadding: false,
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
