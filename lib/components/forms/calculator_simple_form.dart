import 'package:finance_app/components/forms/sections/info/info_simple_share_section.dart';
import 'package:finance_app/components/forms/sections/info/info_sum_section.dart';
import 'package:finance_app/components/forms/sections/input/fees_input_section.dart';
import 'package:finance_app/components/forms/sections/input/simple_input_section.dart';
import 'package:finance_app/components/forms/sections/info/info_fees_section.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
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

  TransactionSumData _transactionSumData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<CalculatorSimpleNotifier>(context);
    _transactionSumData = TransactionSumData(SharesData(
        _profitNotifier.purchasePrice, _profitNotifier.sellingPrice,
        _profitNotifier.sharesQuantity), CommissionsData(
        _profitNotifier.buyCommission, _profitNotifier.sellCommission,
        _profitNotifier.spreadFee));

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
            useBuyPercentage: _transactionSumData.commissionsData.buyCommission.usePercentage,
            useSellPercentage: _transactionSumData.commissionsData.sellCommission.usePercentage,
            useBuyPercentageChanged: _useBuyPercentageChanged,
            useSellPercentageChanged: _useSellPercentageChanged,
          ),
          SizedBox(
            height: 5,
          ),
          InfoSumSection(
            transactionSumData: _transactionSumData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoShareSection(
            transactionSumData: _transactionSumData,
          ),
          SizedBox(
            height: 5,
          ),
          InfoFeesSection(
            transactionSumData: _transactionSumData,
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

  _useBuyPercentageChanged(value) {
    _profitNotifier.buyCommission.usePercentage = value;
    print('${_profitNotifier.buyCommission.value}, ${_profitNotifier.buyCommission.usePercentage}, ${_transactionSumData.totalFees}');
  }

  _useSellPercentageChanged(value) {
    _profitNotifier.sellCommission.usePercentage = value;
  }

  @override
  bool get wantKeepAlive => true;
}
