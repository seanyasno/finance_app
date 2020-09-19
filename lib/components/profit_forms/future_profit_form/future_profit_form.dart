import 'package:finance_app/components/profit_sections/future_sections/future_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_fees_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_share_section.dart';
import 'package:finance_app/components/profit_sections/info_sections/info_sum_section.dart';
import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_info/profit_info.dart';
import 'package:finance_app/models/commission_fee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FutureProfitForm extends StatefulWidget {
  @override
  _FutureProfitFormState createState() => _FutureProfitFormState();
}

class _FutureProfitFormState extends State<FutureProfitForm> {
  double _currentSharePrice = 0;
  double _buyingFee = 0;
  double _sellingFee = 0;
  double _desiredProfit = 0;
  double _spreadFees = 0;
  double _sharesAmount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureShareSection(_currentSharePriceChanged, _desiredProfitChanged,
              _sharesAmountChanged),
          SizedBox(
            height: 5,
          ),
          FeesSection(
              _buyingFeeChanged, _sellingFeeChanged, _spreadFeesChanged),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            purchasePrice: _currentSharePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _sharesAmount.toInt(),
            buyCommission: CommissionFee(_buyingFee, false),
            sellCommission: CommissionFee(_sellingFee, false),
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            purchasePrice: _currentSharePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _sharesAmount.toInt(),
            buyCommission: CommissionFee(_buyingFee, false),
            sellCommission: CommissionFee(_sellingFee, false),
            spreadFee: _spreadFees,
            children: [
              ProfitInfo('Future Share Price',
                  NumberFormat().format(_getFutureSharePrice())),
              SizedBox(height: 10),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            purchasePrice: _currentSharePrice,
            sellingPrice: _getFutureSharePrice(),
            sharesQuantity: _sharesAmount.toInt(),
            buyCommission: CommissionFee(_buyingFee, false),
            sellCommission: CommissionFee(_sellingFee, false),
            spreadFee: _spreadFees,
          ),
        ],
      ),
    );
  }

  _currentSharePriceChanged(value) {
    setState(() {
      _currentSharePrice = double.parse(value);
    });
  }

  _desiredProfitChanged(value) {
    setState(() {
      _desiredProfit = double.parse(value);
    });
  }

  _buyingFeeChanged(value) {
    setState(() {
      _buyingFee = double.parse(value);
    });
  }

  _sellingFeeChanged(value) {
    setState(() {
      _sellingFee = double.parse(value);
    });
  }

  _spreadFeesChanged(value) {
    setState(() {
      _spreadFees = double.parse(value) / 100;
    });
  }

  _sharesAmountChanged(value) {
    setState(() {
      _sharesAmount = double.parse(value);
    });
  }

  double _getFutureSharePrice() {
    return ((_buyingFee + _sellingFee + _desiredProfit)) /
            ((1 - _spreadFees) * _sharesAmount) + _currentSharePrice;

  }
}
