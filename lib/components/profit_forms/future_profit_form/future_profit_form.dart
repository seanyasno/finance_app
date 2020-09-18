import 'package:finance_app/components/profit_sections/fees_section.dart';
import 'package:finance_app/components/profit_sections/future_sections/future_share_section.dart';
import 'package:finance_app/components/profit_sections/info_section.dart';
import 'package:flutter/material.dart';

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
            height: 15,
          ),
          FeesSection(
              _buyingFeeChanged, _sellingFeeChanged, _spreadFeesChanged),
          SizedBox(
            height: 15,
          ),
          InfoSection(
              _currentSharePrice,
              _getFutureSharePrice(),
              _getFutureSharePrice() - _currentSharePrice,
              _sharesAmount,
              _buyingFee,
              _sellingFee,
              _spreadFees / 100),
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
      _spreadFees = double.parse(value);
    });
  }

  _sharesAmountChanged(value) {
    setState(() {
      _sharesAmount = double.parse(value);
    });
  }

  double _getFutureSharePrice() {
    return ((_buyingFee + _sellingFee + _desiredProfit) /
                (1 - 2 * (_spreadFees / 100))) /
            (_sharesAmount == 0 ? 1 : _sharesAmount) +
        _currentSharePrice;
  }
}
