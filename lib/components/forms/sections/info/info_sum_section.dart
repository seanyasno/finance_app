import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoSumSection extends StatelessWidget {
  final SharesData sharesData;
  final CommissionsData commissionsData;

  InfoSumSection({
    @required this.sharesData,
    @required this.commissionsData,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfoExpanded(
          'Total Buying Value',
          NumberFormat().format(_calculateTotalBuyingValue()),
          [
            SectionInnerInfo('Shares Buying Value', NumberFormat().format(sharesData.purchasePrice * sharesData.sharesQuantity)),
            SectionInnerInfo('Buy Commission', NumberFormat().format(commissionsData.buyCommission.calculate(
                data: sharesData.purchasePrice * sharesData.sharesQuantity))),
          ],
        ),
        SectionInnerInfo('Spread', NumberFormat().format(sharesData.spread)),
        SectionInnerInfoExpanded(
          'Total Selling Value',
          NumberFormat().format(_calculateTotalSellingValue()),
          [
            SectionInnerInfo('Shares Buying Value', NumberFormat().format(sharesData.sellingPrice * sharesData.sharesQuantity)),
            SectionInnerInfo('Buy Commission', NumberFormat().format(commissionsData.sellCommission.calculate(
                data: sharesData.sellingPrice * sharesData.sharesQuantity))),
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
    return sharesData.purchasePrice * sharesData.sharesQuantity +
        commissionsData.buyCommission.calculate(data: sharesData.purchasePrice * sharesData.sharesQuantity);
  }

  double _calculateTotalSellingValue() {
    return sharesData.sellingPrice * sharesData.sharesQuantity +
        commissionsData.sellCommission.calculate(data: sharesData.sellingPrice * sharesData.sharesQuantity);
  }
}
