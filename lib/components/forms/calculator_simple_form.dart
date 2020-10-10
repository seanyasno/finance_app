import 'package:finance_app/components/forms/sections/info/info_simple_share_section.dart';
import 'package:finance_app/components/forms/sections/info/info_sum_section.dart';
import 'package:finance_app/components/forms/sections/input/fees_input_section.dart';
import 'package:finance_app/components/forms/sections/input/simple_input_section.dart';
import 'package:finance_app/components/forms/sections/info/info_fees_section.dart';
import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';
import 'package:finance_app/models/data/transaction-sum-data.dart';
import 'package:finance_app/providers/calculators/calculator_simple_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorSimpleForm extends StatefulWidget {
  CalculatorSimpleForm({Key key}) : super(key: key);

  @override
  _CalculatorSimpleFormState createState() => _CalculatorSimpleFormState();
}

class _CalculatorSimpleFormState extends State<CalculatorSimpleForm>
    with AutomaticKeepAliveClientMixin {
  CalculatorSimpleProvider _profitNotifier;

  TransactionSumData _transactionSumData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _profitNotifier = Provider.of<CalculatorSimpleProvider>(context);
    _transactionSumData = TransactionSumData(
        SharesData(_profitNotifier.purchasePrice, _profitNotifier.sellingPrice,
            _profitNotifier.sharesQuantity),
        CommissionsData(_profitNotifier.buyCommission,
            _profitNotifier.sellCommission, _profitNotifier.spreadFee));

    return Container(
      child: Column(
        children: [
          SimpleInputSection(
            (value) => _profitNotifier.purchasePrice = double.parse(value),
            (value) => _profitNotifier.sellingPrice = double.parse(value),
            (value) => _profitNotifier.sharesQuantity = int.parse(value),
          ),
          SizedBox(
            height: 5,
          ),
          FeesInputSection(
            onBuyingFeeChanged: (value) =>
                _profitNotifier.buyCommission.value = double.parse(value),
            onSellingFeeChanged: (value) =>
                _profitNotifier.sellCommission.value = double.parse(value),
            onSpreadFeeChanged: (value) =>
                _profitNotifier.spreadFee = double.parse(value) / 100,
            useBuyPercentage:
                _transactionSumData.commissionsData.buyCommission.usePercentage,
            useSellPercentage: _transactionSumData
                .commissionsData.sellCommission.usePercentage,
            useBuyPercentageChanged: (value) {
              setState(() {
                _profitNotifier.buyCommission.usePercentage = value;
              });
            },
            useSellPercentageChanged: (value) {
              setState(() {
                _profitNotifier.sellCommission.usePercentage = value;
              });
            },
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

  @override
  bool get wantKeepAlive => true;
}
