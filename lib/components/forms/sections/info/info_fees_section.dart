import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoFeesSection extends StatelessWidget {
  final TransactionSumData transactionSumData;

  InfoFeesSection({
    Key key,
    @required this.transactionSumData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfoExpanded(
          'Total Fees',
          NumberFormat().format(transactionSumData.totalFees),
          [
            SectionInnerInfo(
              'Buy Commission',
              NumberFormat().format(
                  transactionSumData.commissionsData.buyCommission.calculate(
                      data: transactionSumData.sharesData.purchasePrice *
                          transactionSumData.sharesData.sharesQuantity)),
            ),
            SectionInnerInfo(
              'Sell Commission',
              NumberFormat().format(
                  transactionSumData.commissionsData.sellCommission.calculate(
                      data: transactionSumData.sharesData.sellingPrice *
                          transactionSumData.sharesData.sharesQuantity)),
            ),
            SectionInnerInfo(
              'Spread Fee',
              NumberFormat().format(transactionSumData.spreadFee),
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
}
