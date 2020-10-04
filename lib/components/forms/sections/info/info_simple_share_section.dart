import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoShareSection extends StatelessWidget {
  final SharesData sharesData;
  final CommissionsData commissionsData;

  InfoShareSection({
    @required this.sharesData,
    @required this.commissionsData,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      inners: [
        SectionInnerInfo(
          'Profit / Loss',
          NumberFormat().format(_calculateProfit()),
        ),
        SectionInnerInfo(
          'Share Growth (%)',
          _fixNaN(NumberFormat()
              .format((sharesData.sellingPrice - sharesData.purchasePrice) / sharesData.purchasePrice * 100)),
        ),
        SectionInnerInfo(
          'Return On Investment (%)',
          _fixNaN(NumberFormat().format(_calculateROI())),
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

  double _calculateProfit() {
    return (sharesData.sellingPrice * sharesData.sharesQuantity) -
        (sharesData.purchasePrice * sharesData.sharesQuantity) -
        (sharesData.sellingPrice > sharesData.purchasePrice
            ? _calculateTotalFees()
            : commissionsData.buyCommission.calculate(data: sharesData.sharesQuantity * sharesData.purchasePrice) +
            commissionsData.sellCommission.calculate(data: sharesData.sharesQuantity * sharesData.sellingPrice));
  }

  double _calculateTotalFees() {
    double spread =
        (sharesData.sellingPrice * sharesData.sharesQuantity) - (sharesData.purchasePrice * sharesData.sharesQuantity);
    return commissionsData.buyCommission.calculate(data: sharesData.sharesQuantity * sharesData.purchasePrice) +
        commissionsData.sellCommission.calculate(data: sharesData.sharesQuantity * sharesData.sellingPrice) +
        (sharesData.sellingPrice > sharesData.purchasePrice ? spread * commissionsData.spreadFee : 0);
  }

  double _calculateROI() {
    double totalCommissions =
        commissionsData.buyCommission.calculate(data: sharesData.sharesQuantity * sharesData.purchasePrice) +
            commissionsData.sellCommission.calculate(data: sharesData.sharesQuantity * sharesData.sellingPrice);
    return (_calculateProfit() /
            (sharesData.purchasePrice * sharesData.sharesQuantity + totalCommissions)) *
        100;
  }
}
