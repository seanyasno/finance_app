import 'package:finance_app/components/forms/section_cards/section_card.dart';
import 'package:finance_app/models/sections/section_inner_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoShareSection extends StatelessWidget {
  final double purchasePrice;
  final double sellingPrice;
  final int sharesQuantity;

  final CommissionFee buyCommission;
  final CommissionFee sellCommission;
  final double spreadFee;

  InfoShareSection({
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
        SectionInnerInfo(
          'Profit / Loss',
          NumberFormat().format(_calculateProfit()),
        ),
        SectionInnerInfo(
          'Share Growth (%)',
          _fixNaN(NumberFormat()
              .format((sellingPrice - purchasePrice) / purchasePrice * 100)),
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
    return (sellingPrice * sharesQuantity) -
        (purchasePrice * sharesQuantity) -
        (sellingPrice > purchasePrice
            ? _calculateTotalFees()
            : buyCommission.calculate(data: sharesQuantity * purchasePrice) +
                sellCommission.calculate(data: sharesQuantity * sellingPrice));
  }

  double _calculateTotalFees() {
    double spread =
        (sellingPrice * sharesQuantity) - (purchasePrice * sharesQuantity);
    return buyCommission.calculate(data: sharesQuantity * purchasePrice) +
        sellCommission.calculate(data: sharesQuantity * sellingPrice) +
        (sellingPrice > purchasePrice ? spread * spreadFee : 0);
  }

  double _calculateROI() {
    double totalCommissions =
        buyCommission.calculate(data: sharesQuantity * purchasePrice) +
            sellCommission.calculate(data: sharesQuantity * sellingPrice);
    return (_calculateProfit() /
            (purchasePrice * sharesQuantity + totalCommissions)) *
        100;
  }
}
