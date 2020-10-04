import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoFeesSection extends StatelessWidget {
  final SharesData sharesData;
  final CommissionsData commissionsData;

  InfoFeesSection({
    @required this.sharesData,
    @required this.commissionsData,
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
                  commissionsData.buyCommission.calculate(data: sharesData.purchasePrice * sharesData.sharesQuantity)),
            ),
            SectionInnerInfo(
              'Sell Commission',
              NumberFormat().format(
                  commissionsData.sellCommission.calculate(data: sharesData.sellingPrice * sharesData.sharesQuantity)),
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
    return commissionsData.buyCommission.calculate(data: sharesData.purchasePrice * sharesData.sharesQuantity) +
        commissionsData.sellCommission.calculate(data: sharesData.sellingPrice * sharesData.sharesQuantity) +
        _calculateSpreadFee();
  }

  double _calculateSpreadFee() {
    if (sharesData.sellingPrice <= sharesData.purchasePrice) return 0;
    return commissionsData.spreadFee *
        ((sharesData.sellingPrice * sharesData.sharesQuantity) - (sharesData.purchasePrice * sharesData.sharesQuantity));
  }
}
