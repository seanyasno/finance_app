import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoShareSection extends StatelessWidget {
  final TransactionSumData transactionSumData;

  InfoShareSection({
    @required this.transactionSumData,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfo(
          'Profit / Loss',
          NumberFormat().format(transactionSumData.profit),
        ),
        SectionInnerInfo(
          'Share Growth (%)',
          _fixNaN(NumberFormat()
              .format((transactionSumData.sharesData.sellingPrice - transactionSumData.sharesData.purchasePrice) / transactionSumData.sharesData.purchasePrice * 100)),
        ),
        SectionInnerInfo(
          'Return On Investment (%)',
          _fixNaN(NumberFormat().format(transactionSumData.roi)),
        ),
      ],
      gradientColors: [
        Color(0xFF56CCF2),
        Color(0xFF2F80ED),
      ],
    );
  }

  String _fixNaN(String value) {
    return value == "NaN" ? '0' : value;
  }
}
