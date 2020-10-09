import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoDesiredShareSection extends StatelessWidget {
  final TransactionSumData transactionSumData;

  InfoDesiredShareSection({
    Key key,
    @required this.transactionSumData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfo(
          'Future Share Price',
          NumberFormat().format(transactionSumData.sharesData.sellingPrice),
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
