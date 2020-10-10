import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/models/sections/section_inner_info_expanded.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoSumSection extends StatelessWidget {
  final TransactionSumData transactionSumData;

  InfoSumSection({
    Key key,
    @required this.transactionSumData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfoExpanded(
          'Total Buying Value',
          NumberFormat().format(_calculateTotalBuyingValue()),
          [
            SectionInnerInfo(
                'Shares Buying Value',
                NumberFormat().format(
                    transactionSumData.sharesData.purchasePrice *
                        transactionSumData.sharesData.sharesQuantity)),
            SectionInnerInfo(
                'Buy Commission',
                NumberFormat().format(
                    transactionSumData.commissionsData.buyCommission.calculate(
                        data: transactionSumData.sharesData.purchasePrice *
                            transactionSumData.sharesData.sharesQuantity))),
          ],
        ),
        SectionInnerInfo(
            'Spread',
            _fixNaN(
                NumberFormat().format(transactionSumData.sharesData.spread))),
        SectionInnerInfoExpanded(
          'Total Selling Value',
          _fixNaN(NumberFormat().format(_calculateTotalSellingValue())),
          [
            SectionInnerInfo(
                'Shares Buying Value',
                _fixNaN(NumberFormat().format(
                    transactionSumData.sharesData.sellingPrice *
                        transactionSumData.sharesData.sharesQuantity))),
            SectionInnerInfo(
                'Buy Commission',
                NumberFormat().format(
                    transactionSumData.commissionsData.sellCommission.calculate(
                        data: transactionSumData.sharesData.sellingPrice *
                            transactionSumData.sharesData.sharesQuantity))),
            SectionInnerInfo('Spread Fee',
                _fixNaN(NumberFormat().format(transactionSumData.spreadFee))),
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
    return transactionSumData.sharesData.purchasePrice *
            transactionSumData.sharesData.sharesQuantity +
        transactionSumData.commissionsData.buyCommission.calculate(
            data: transactionSumData.sharesData.purchasePrice *
                transactionSumData.sharesData.sharesQuantity);
  }

  double _calculateTotalSellingValue() {
    return transactionSumData.sharesData.sellingPrice *
            transactionSumData.sharesData.sharesQuantity -
        transactionSumData.commissionsData.sellCommission.calculate(
            data: transactionSumData.sharesData.sellingPrice *
                transactionSumData.sharesData.sharesQuantity) -
        transactionSumData.spreadFee;
  }

  String _fixNaN(String value) {
    return value == "NaN" ? '0' : value;
  }
}
