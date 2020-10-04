import 'package:finance_app/components/forms/sections/info/info_share_section.dart';
import 'package:finance_app/components/forms/sections/info/info_sum_section.dart';
import 'package:finance_app/components/forms/sections/input/fees_input_section.dart';
import 'package:finance_app/components/forms/sections/input/simple_input_section.dart';
import 'package:finance_app/components/forms/sections/info/info_fees_section.dart';
import 'package:finance_app/notifiers/calculators/calculator_simple_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorSimpleForm extends StatefulWidget {
  @override
  _CalculatorSimpleFormState createState() => _CalculatorSimpleFormState();
}

class _CalculatorSimpleFormState extends State<CalculatorSimpleForm>
    with AutomaticKeepAliveClientMixin {
  CalculatorSimpleNotifier _profitNotifier;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<CalculatorSimpleNotifier>(context);

    return Container(
      child: Column(
        children: [
          SimpleInputSection(
            _purchasePriceChanged,
            _sellingPriceChanged,
            _sharesQuantityChanged,
          ),
          SizedBox(
            height: 5,
          ),
          FeesInputSection(
            onBuyingFeeChanged: _buyCommissionChanged,
            onSellingFeeChanged: _sellCommissionChanged,
            onSpreadFeeChanged: _spreadFeesChanged,
          ),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            purchasePrice: _profitNotifier.purchasePrice,
            sellingPrice: _profitNotifier.sellingPrice,
            sharesQuantity: _profitNotifier.sharesQuantity,
            buyCommission: _profitNotifier.buyCommission,
            sellCommission: _profitNotifier.sellCommission,
            spreadFee: _profitNotifier.spreadFee,
          ),
        ],
      ),
    );
  }

  _purchasePriceChanged(value) {
    _profitNotifier.purchasePrice = double.parse(value);
  }

  _sellingPriceChanged(value) {
    _profitNotifier.sellingPrice = double.parse(value);
  }

  _sharesQuantityChanged(value) {
    _profitNotifier.sharesQuantity = int.parse(value);
  }

  _buyCommissionChanged(value) {
    _profitNotifier.buyCommission.value = double.parse(value);
  }

  _sellCommissionChanged(value) {
    _profitNotifier.sellCommission.value = double.parse(value);
  }

  _spreadFeesChanged(value) {
    _profitNotifier.spreadFee = double.parse(value) / 100;
  }

  double _calculateProfit() {
    double purchaseValue =
        _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;

    return (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
        (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity) -
        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
            ? _calculateTotalFees()
            : _profitNotifier.buyCommission.calculate(data: purchaseValue) +
                _profitNotifier.sellCommission.calculate(data: purchaseValue));
  }

  double _calculateTotalFees() {
    double purchaseValue =
        _profitNotifier.purchasePrice * _profitNotifier.sharesQuantity;
    double spread =
        (_profitNotifier.sellingPrice * _profitNotifier.sharesQuantity) -
            (_profitNotifier.purchasePrice * _profitNotifier.sharesQuantity);
    return _profitNotifier.buyCommission.calculate(data: purchaseValue) +
        _profitNotifier.sellCommission.calculate(data: purchaseValue) +
        (_profitNotifier.sellingPrice > _profitNotifier.purchasePrice
            ? spread * _profitNotifier.spreadFee
            : 0);
  }

  @override
  bool get wantKeepAlive => true;
}
